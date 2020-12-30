---
layout: post
date:   2020-12-30 16:30:36 +0530
title: "Backups on AWS S3 with Duplicity built from source on a Raspberry Pi"
categories: Backup HowTo
published: false
---
Recently, my Raspberry Pi and the attached hard drive crashed. Both, I am using as a network attached storage for storing a lot of my data. Fortunately, I was able to restore most of the data. As a lesson-learned from this, I started to look out for a backup solution for my freshly set up Raspberry Pi.

This post is my HowTo about setting up backups on AWS S3 with [Duplicity](http://duplicity.nongnu.org/) on my Raspberry Pi based on Raspbian Buster built from source.

# The Requirements

My requirements for the backup solution were:
  * The backups should be automatable.
  * The backup solution should be able to use different backup destinations. Preferrably, I wanted to use [AWS Simple Storage Service (S3)](https://aws.amazon.com/s3/) or [Google Cloud Storage (GCS)](https://cloud.google.com/storage) in order to have a safe storage location (safe in the sense of no hard drive outages on my side). Eventually, I decided to go for AWS S3.
  * The backups should be encrypted, because of the requirement for storing the backups on AWS S3.
  * Due to the sheer size of the different backups and using AWS S3, the backup solution should be able to run incremental backups.

# Duplicity

In this HowTo, I will use [Duplicity](http://duplicity.nongnu.org/). Duplicity has strong support for encrypting the backups. It seemed to be able to use different backends such as AWS S3, GCS, etc. Furthermore, Duplicity is available as a Debian/Raspbian package for a simply installation. For further details, I refer to Duplicity.

If you want to look at some other HowTo's and Tutorials, please refer to:
  * [Debian Duplicity documentation](https://wiki.debian.org/Duplicity)
  * [Ubuntu Duplicity documentation](https://help.ubuntu.com/community/DuplicityBackupHowto)
  * [This post about using AWS S3 with Duplicity](https://icicimov.github.io/blog/devops/Duplicity-encrypted-backups-to-Amazon-S3/) or
  * [This post about using AWS S3 with Duplicity](https://feeding.cloud.geek.nz/posts/backing-up-to-s3-with-duplicity/).

## Issues with the Duplicity Debian/Raspbian Package

When you want to use some newer AWS S3 features or the Frankfurt data center, you should rather use Duplicity series 0.8. The main reason is an outdated library. At the time of writing this post, the Debian/Raspbian package was based on Duplicity series 0.7 (0.7.18.2-1; see, e.g.: [Debian Packages](https://packages.debian.org/search?keywords=duplicity)). Duplicity 0.7 uses Python 2.7 and [Boto](https://github.com/boto/boto) for AWS support such as S3. Python has reached End Of Life and also Boto has been updated last in 2018. It does not work with newer features at AWS. The next version of Boto is [Boto3](https://github.com/boto/boto3) which is used by Duplicity series 0.8.

As I am using the Frankfurt data center (eu-central-1) as my nearest AWS data center, I was straight running into a bug of Duplicity and Boto due to the fact of being outdated in Duplicity series 0.7. The Frankfurt AWS data center uses AWS Signature Version 4 which is supported by Boto, but is not default for Boto (see also: [Boto Issue - S3 bucket lookup / get_bucket broken for eu-central-1 (Frankfurt)](https://github.com/boto/boto/issues/2741)). Although, you can enable AWS Signature Version 4 in Boto, Duplicity was still not able to make use of S3 in that specific version I was using.

While it seems that there is a new Debian/Raspbian package on the way, I did not want to wait until the release of the new Debian/Raspbian package. Also, fixes for Duplicity series 0.7 seem not to be valuable, because series 0.8 is stable and should be used. Eventually, my solution was to build and install Duplicity from source on my own.

## Solution Options

  1. Waiting for the Debian/Raspbian package
  1. Fixing the bug in the source code of Duplicity series 0.7 and Boto 
  1. Compiling Duplicity series 0.8 on Debian/Raspbian on my own from source

## Compiling Duplicity Series 0.8 from Source with Python3
# Summary
