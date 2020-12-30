---
layout: post
date:   2020-12-30 16:30:36 +0530
title: "My Thoughts and Consequences on typical Issues with usual HowTo's on the Internet"
categories:
  - Thoughts
  - HowTo
published: true
---
Recently, my Raspberry Pi and the attached hard drive crashed. Both, I am using as a network attached storage for storing a lot of my data. Fortunately, I was able to restore most of the data. As a lesson-learned from this, I started to look out for a backup solution for my freshly set up Raspberry Pi.

This post is my opinionated HowTo about setting up backups on AWS S3 with Duplicity on my Raspberry Pi based on Raspbian Buster built from source.

# The Requirements

My requirements for the backup solution were:
  * The backups should be automatable.
  * The backup solution should be able to use different backup destinations. Preferrably, I wanted to use [AWS Simple Storage Service (S3)](https://aws.amazon.com/s3/) or [Google Cloud Storage (GCS)](https://cloud.google.com/storage) in order to have a safe storage location (safe in the sense of no hard drive outages on my side). Eventually, I decided to go for AWS S3.
  * The backups should be encrypted, because of the requirement for storing the backups on AWS S3.
  * Due to the sheer size of the different backups and using AWS S3, the backup solution should be able to run incremental backups.

# Duplicity - the First Attempt
## Using Tutorials/HowTo's

Soon, I found a "nice" backup tool for Debian/Raspbian: [Duplicity](http://duplicity.nongnu.org/). Duplicity has strong support for encrypting the backups. It seemed to be able to use different backends such as AWS S3, GCS, etc. Furthermore, Duplicity is available as a Debian/Raspbian package for a simply installation. For further details, I refer to Duplicity.

So, I started with setting up the solution on my Raspberry Pi. There are a lot tuturials about duplicity such as the [Debian Duplicity documentation](https://wiki.debian.org/Duplicity) or the [Ubuntu Duplicity documentation](https://help.ubuntu.com/community/DuplicityBackupHowto). Also, there are some blog posts about setting up Duplicity with AWS S3 such as [this post](https://icicimov.github.io/blog/devops/Duplicity-encrypted-backups-to-Amazon-S3/) or [this post](https://feeding.cloud.geek.nz/posts/backing-up-to-s3-with-duplicity/).

Unfortunately, I was not successful with setting up Duplicity with AWS S3 using these tutorials due to issues with the Duplicity Debian/Raspbian package. Duplicity always complained: `The authorization mechanism you have provided is not supported. Please use AWS4-HMAC-SHA256.`

## Issues with the Duplicity Debian/Raspbian Package

The main reason of the above issue is an outdated library. At the time of writing this post, the Debian/Raspbian package was based on Duplicity series 0.7 (0.7.18.2-1; see, e.g.: [Debian Packages](https://packages.debian.org/search?keywords=duplicity)). Duplicity 0.7 uses Python 2.7 and [Boto](https://github.com/boto/boto) for AWS support such as S3. Python has reached End Of Life and also Boto has been updated last in 2018. It does not work with newer features at AWS. The next version of Boto is [Boto3](https://github.com/boto/boto3) which is used by Duplicity series 0.8.

As I am using the Frankfurt data center (eu-central-1) as my nearest AWS data center, I was straight running into a bug of Duplicity and Boto due to the fact of being outdated in Duplicity series 0.7. The Frankfurt AWS data center uses AWS Signature Version 4 which is supported by Boto, but is not default for Boto (see also: [Boto Issue - S3 bucket lookup / get_bucket broken for eu-central-1 (Frankfurt)](https://github.com/boto/boto/issues/2741)). Although, you can enable AWS Signature Version 4 in Boto, Duplicity was still not able to make use of S3 in that specific version I was using.

While it seems that there is a new Debian/Raspbian package on the way, I did not want to wait until the release of the new Debian/Raspbian package. Also, fixes for Duplicity series 0.7 seem not to be valuable, because series 0.8 is stable and should be used. Eventually, my solution was to build and install Duplicity from source on my own.

# Summary

- 