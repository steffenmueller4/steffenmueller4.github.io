---
layout: post
date:   2020-12-30 16:30:36 +0530
title: "Backups on AWS S3 with Duplicity built from source on a Raspberry Pi"
categories: Backup HowTo Raspberry-Pi
published: false
---
Recently, my Raspberry Pi and the attached hard drive crashed. Both, I am using as a network attached storage for storing a lot of my data. Fortunately, I was able to restore most of the data. As a lesson-learned from that incident, I started to look out for a backup solution for my freshly set up Raspberry Pi.

This post is my howto setting up backups on AWS S3 with [Duplicity](http://duplicity.nongnu.org/) on my Raspberry Pi based on Raspbian Buster built from source.

# Requirements

My requirements for the backup solution were:
  * The backups should be automatable.
  * The backup solution should be able to use different backup destinations. Preferrably, I wanted to use [AWS Simple Storage Service (S3)](https://aws.amazon.com/s3/) or [Google Cloud Storage (GCS)](https://cloud.google.com/storage) in order to have a safe storage location (safe in the sense of no hard drive outages on my side). Eventually, I decided to go for AWS S3.
  * The backups should be encrypted, because of the requirement for storing the backups on AWS S3.
  * Due to the sheer size of the different backups and using AWS S3, the backup solution should be able to run incremental backups.

# Solution: Duplicity

Based on my requirements, I decided to use [Duplicity](http://duplicity.nongnu.org/). Duplicity has a strong support for encrypting the backups via [GnuPGP](https://gnupg.org/). It is able to use different backends such as AWS S3, GCS, etc. Furthermore, Duplicity is available as a Debian/Raspbian package for a simply installation. For further details, I refer to the Duplicity site and documentation.

If you want to have a look at some other howto's and tutorials to set up Duplicity without and with AWS S3, please refer to:
  * [Debian Duplicity documentation](https://wiki.debian.org/Duplicity)
  * [Ubuntu Duplicity documentation](https://help.ubuntu.com/community/DuplicityBackupHowto)
  * [This post about using AWS S3 with Duplicity](https://icicimov.github.io/blog/devops/Duplicity-encrypted-backups-to-Amazon-S3/) or
  * [This post about using AWS S3 with Duplicity](https://feeding.cloud.geek.nz/posts/backing-up-to-s3-with-duplicity/).

## Issues with the Duplicity Debian/Raspbian Package (as of 2020-12-31)

At the time of writing this howto, the [Debian/Raspbian package Duplicity](https://packages.debian.org/search?keywords=duplicity) was based on Duplicity series 0.7 (exactly, 0.7.18.2-1). When you want to use newer AWS S3 features such as [storage class Infrequent Access or Glacier](https://aws.amazon.com/s3/features/?nc=sn&loc=2) to save costs or, maybe, the AWS Frankfurt data center (eu-central-1), you should rather use Duplicity series 0.8. The main reason is an outdated library in Duplicity series 0.7. Duplicity 0.7 uses Python 2.7 and [Boto](https://github.com/boto/boto) for AWS support. Boto has been updated last in 2018 - a long time ago in IT. So, Boto does not work with newer features at AWS such as the newer APIs of the Frankfurt data center (see also: [Boto Issue - S3 bucket lookup / get_bucket broken for eu-central-1 (Frankfurt)](https://github.com/boto/boto/issues/2741)). When you use Duplicity series 0.7 in combination with Boto and the Frankfurt AWS data center, you may see an error such as: `The authorization mechanism you have provided is not supported. Please use AWS4-HMAC-SHA256.`.

While it seems that there is a new Debian/Raspbian package based on Duplicity 0.8.17-1+b1 on the way, I did not want to wait until the release of the new Debian/Raspbian package. Also, fixes for Duplicity series 0.7 seem not to be valuable, because series 0.8 is stable and should be used in future - Duplicity series 0.8 uses [Boto3](https://github.com/boto/boto3) the newer version of Boto. Eventually, I decided to build and install Duplicity on my own.

## Solution Options

  1. Waiting for the Debian/Raspbian package
  1. Fixing the bug in the source code of Duplicity series 0.7 and Boto 
  1. Compiling Duplicity series 0.8 on Debian/Raspbian on my own from source

## Compiling Duplicity Series 0.8 from Source with Python3
# Summary
