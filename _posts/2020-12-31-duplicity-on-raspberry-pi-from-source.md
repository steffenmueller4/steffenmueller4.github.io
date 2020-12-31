---
layout: post
date:   2020-12-31 09:59:36 +0530
title: "Backups to AWS S3 with Duplicity built from source on a Raspberry Pi"
categories: Backup HowTo Raspberry-Pi
published: true
---
Recently, my Raspberry Pi and the attached hard drive crashed. Both, I am using as a network attached storage for storing a lot of my data. Fortunately, I was able to restore most of the data. As a lesson-learned from that incident, I started to look out for a backup solution for my freshly set up Raspberry Pi (Raspbian Buster).

This post is my howto for setting up backups with [Duplicity][duplicity] using [AWS Simple Storage Service (S3)][aws-s3] as the remote backup destination on Raspbian Buster built from source with Python 3 and Boto3.

# Requirements

My requirements for the backup solution are:
  * The backups should be automatable/run every night.
  * The backup solution should be able to use different remote backup destinations. Preferrably, I wanted to use AWS S3 or [Google Cloud Storage (GCS)][gcs] in order to have a safe storage location - safe in the sense of no hard drive crashes I have to deal with. Eventually, I decided to go for AWS S3.
  * The backups should be encrypted because of the previous requirement for storing the backups on AWS S3.
  * Due to the sheer size of the different backups and using AWS S3 as a remote backup destination, the backup solution should be able to run incremental backups to reduce the amount of data that has to be uploaded every day to AWS S3.

# Solution: Duplicity

Based on my requirements, I decided to go for Duplicity. Duplicity has a strong support for encrypting the backups based on [GnuPGP][gnu-pgp] (see also: [Duplicity][duplicity]). It is able to use different backends such as AWS S3, GCS, etc. Furthermore, Duplicity seemed to be available as a Debian/Raspbian package for a simple installation (more details later in this post). For further details about Duplicity, please refer to the Duplicity [site][duplicity] and documentation.

If you want to have a look at some other people's howtos and tutorials to set up Duplicity, please refer to:
  * [Debian Duplicity documentation][debian-duplicity]
  * [Ubuntu Duplicity documentation][ubuntu-duplicity]
  * [Igor Cicimov's post about using Duplicity with AWS S3][igor-duplicity] or
  * [François Marier's post about using Duplicity with AWS S3][francois-duplicity].

# Installation

As explained, for example, in [Igor Cicimov's post about using AWS S3 with Duplicity][igor-duplicity], you can install Duplicity with AWS S3 support on Debian/Raspbian Buster easily via:
```
sudo apt install -y duplicity python-boto
```

At the time of writing this howto (2020-12-31), this simple installation does, unfortunately, not work when you want to use latest AWS S3 features or, for example, a bucket in the Frankfurt AWS data center (eu-central-1). The main reason for that, is the outdated [Boto][boto] library which is used by Duplicity series 0.7 to access AWS. Boto has been updated last in 2018 - in IT a long time ago. When you try to use Duplicity series 0.7 and the Boto version packaged with the `Python-boto` Debian/Raspbian package, you may encounter different errors such as: `The authorization mechanism you have provided is not supported. Please use AWS4-HMAC-SHA256.` (see also: [Boto Issue - S3 bucket lookup / get_bucket broken for eu-central-1 (Frankfurt)][boto-issue-frankfurt]). To make use of latest AWS S3 features, you should use [Boto3][boto3], a new Boto implementation. Using Boto3, seems, however, to require Duplicity series 0.8. I was not able to make Duplicity series 0.7 work with `Python-boto3` Debian/Raspbian package.

The next section is about diverse issues with the given simple way to install Duplicity, and gives you the reasoning why I, eventually, decided to build and install Duplicity from source on my own.

## Issues with the Duplicity/Python-boto Debian/Raspbian Packages (as of 2020-12-31)

As of 2020-12-31, the Debian/Raspbian package `Duplicity` is based on [Duplicity 0.7.18.2-1](https://packages.debian.org/buster/duplicity) (series 0.7). The Debian/Raspbian package `Python-boto` is based on [Boto 2.44.0-1.1](https://packages.debian.org/buster/python-boto). When you want to use newer AWS S3 features such as [storage class Infrequent Access or Glacier](https://aws.amazon.com/s3/features/?nc=sn&loc=2) to save costs, you need to use a newer Boto version (>= Boto 2.7.0, see also: [Duplicity][duplicity]). You may be able to install this combination via installing Duplicity and newest Boto version via [Pip - a Python package installer][pip] instead of the Debian/Raspbian package `Python-boto` via the apt command given in the previous section (Warning: I did not try this out eventually, so it may not work completely):
```
sudo apt install duplicity python-pip
pip install boto
```

This, however, will very likely still not work when you want to use, for example, an AWS S3 bucket in the Frankfurt data center (eu-central-1). As already explained, Duplicity series 0.7 uses Boto. On top of that, Duplicity series 0.7 and Boto do not use the latest AWS authentication mechanism, [AWS Signature Version 4][aws-signature-4] (see also: [Boto Issue - S3 bucket lookup / get_bucket broken for eu-central-1 (Frankfurt)][boto-issue-frankfurt]), and a lot of other changes on AWS APIs. Using Duplicity 0.7.18.2-1 and Boto, will then probably lead to this error: `The authorization mechanism you have provided is not supported. Please use AWS4-HMAC-SHA256.` Although I am sure that there is also a way to fix Duplicity series 0.7 and Boto when using the Frankfurt data center, I eventually decided to go for Duplicity series 0.8 and [Boto3][boto3], the newer version of Boto due all the issues with Duplicity series 0.7 and Boto.

While it seems that there is a new Debian/Raspbian package based on Duplicity 0.8.17-1+b1 on the way (as of 2020-12-31), I do not want to wait until the release of the new Debian/Raspbian package. I decided to build and install Duplicity series 0.8 with Python 3 and Boto3 on my own. The next section is about doing that.

## Build Duplicity series 0.8 with Python 3 and Boto3 from source

For building and installing Duplicity series 0.8 with Python 3 and Boto3 from source, you can run the following commands (tested on an up-to-date Raspbian Buster on 2020-12-30 - run as root user):
```
# Install various dependencies such as curl, tar, and Pip as well as
# build dependencies for Duplicity such as the Python3 development library
apt install -y curl tar python3-pip python3-dev librsync-dev gettext

# Download Duplicity 0.8.17 to user's home directory
curl -o ~/duplicity.tar.gz https://gitlab.com/duplicity/duplicity/-/archive/rel.0.8.17/duplicity-rel.0.8.17.tar.gz

# Create a Duplicity source directory in user's home directry and extract Duplicity
mkdir -p ~/duplicity
tar -xzf ~/duplicity.tar.gz -C ~/duplicity --strip-components 1
cd ~/duplicity || exit

# Install Python 3 requirements for Duplicity including Boto3
pip3 install fasteners future boto3

# Build and install Duplicity 0.8.17
python3 setup.py install --prefix=/usr
```

# Duplicity Backup Configuration

After the torture of installation, the fun part comes now: configuring the actual backups.

## Configuring an AWS S3 Bucket and GnuPGP

Before pushing backups to AWS S3, an AWS S3 bucket needs to be configured properly. For doing so, I refer to [François Marier's post about using Duplicity with AWS S3][francois-duplicity]. Additionally, you need to configure GnuPGP - here [Igor Cicimov's post about using Duplicity with AWS S3][igor-duplicity] may be of help for you.

## Configuring Backups

In order to not expose credentials and reuse them in other backup scripts, I created a separate credentials file in the root user's home directory (backup will be run as root) at `/root/backup_auth.cfg`:
```
# Passphrase for accessing the GPG key, see also: Igor Cicimov's post about using Duplicity with AWS S3
PASSPHRASE="<A_SECURE_PASSPHRASE>"
# The GPG key id for encrypting the backup
ENCRKEY="<THE_GPG_KEY_ID>"
SIGNKEY="${ENCRKEY}"
# AWS credentials for the backup user
AWS_ACCESS_KEY_ID="<THE_AWS_ACCESS_KEY_ID>"
AWS_SECRET_ACCESS_KEY="<THE_AWS_SECRET_ACCESS_KEY>"
```
Please set the values for the variables according to your values.

Next, I created a bash script to run the actual backup at `/root/backup.sh`:
```
#!/bin/bash
set +eu

# Source the separate credentials file
# shellcheck disable=SC1091
. /root/backup_auth.cfg

# Export all environment variables from the separate credentials file
export PASSPHRASE="${PASSPHRASE}"
export ENCRKEY="${ENCRKEY}"
export SIGNKEY="${SIGNKEY}"
export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"

DUPOPTS=""
# Preparing the actual duplicity command
# Please refer to http://duplicity.nongnu.org/vers8/duplicity.1.html for finding out about the options
DUPEXEC="duplicity --encrypt-key ${ENCRKEY} --sign-key ${SIGNKEY} --s3-use-new-style --s3-use-ia --s3-use-multiprocessing $DUPOPTS"
BACKUP_SOURCE="<SOME_DIRECTORY_YOU_WOULD_LIKE_TO_BACKUP"
BACKUP_DESTINATION="boto3+s3://<THE_AWS_S3_BUCKET_NAME>/<SOME_SUBDIRECTORY_YOU_WANT_TO_USE>"

# Doing a monthly full backup (1M), otherwise doing incremental backups
eval "${DUPEXEC} --full-if-older-than 1M ${BACKUP_SOURCE} ${BACKUP_DESTINATION}"

# Cleaning the remote backup space (deleting backups older than 6 months (6M, alternatives would 1Y fo 1 year etc.)
eval "${DUPEXEC} remove-older-than 6M --force ${BACKUP_DESTINATION}"

# Remove all environment variables we set before
unset PASSPHRASE
unset ENCRKEY
unset SIGNKEY
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
```
Please replace the values for the variables `BACKUP_SOURCE` and `BACKUP_DESTINATION` in the above script according to your requirements.

Finally, I created a crontab entry via `crontab -e` to run the backups every night at 01:30:
```
[...]
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
30  1   *   *   *    /bin/bash -c "/root/backup.sh" >>/var/log/duplicity/backup.log
```

# Summary

That is it. In this howto, I described how to backup files from a Raspberry Pi (Raspbian Buster - up-to-date on 2020-12-30) with Duplicity to AWS S3. For that, I installed Duplicity 0.8.17 from source with Python 3 and Boto3 due to Debian/Raspbian Duplicity and Python-boto packages being out of date for my purposes.

As with every howto/tutorial, updates to the used software may change the entire approach and solution. So, please reason about the steps when reading and applying the howto. If you want to report issues with the steps/scripts (I cannot promise that I will fix them ;-)), please use the issues functionality at the [underlying GitHub repository][pages-github-repo].

[//]: # (#)
[//]: # (References)
[//]: # (#)

[duplicity]: http://duplicity.nongnu.org/
[aws-s3]: https://aws.amazon.com/s3/
[gcs]: https://cloud.google.com/storage
[gnu-pgp]: https://gnupg.org/
[debian-duplicity]: https://wiki.debian.org/Duplicity
[ubuntu-duplicity]: https://help.ubuntu.com/community/DuplicityBackupHowto
[igor-duplicity]: https://icicimov.github.io/blog/devops/Duplicity-encrypted-backups-to-Amazon-S3/
[francois-duplicity]: https://feeding.cloud.geek.nz/posts/backing-up-to-s3-with-duplicity/
[boto]: https://github.com/boto/boto
[boto-issue-frankfurt]: https://github.com/boto/boto/issues/2741
[aws-signature-4]: https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html
[pip]: https://en.wikipedia.org/wiki/Pip_(package_manager)
[boto3]: https://github.com/boto/boto3
[pages-github-repo]: https://github.com/steffenmueller4/steffenmueller4.github.io/issues