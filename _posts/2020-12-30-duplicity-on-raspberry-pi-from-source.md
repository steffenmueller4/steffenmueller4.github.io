---
layout: post
date:   2019-03-23 21:03:36 +0530
title: "Backups on AWS S3 with Duplicity built from source on a Raspberry Pi"
categories:
  - Tutorials
  - AWS
published: true
---
Recently, my Raspberry Pi (RPi-One) and the attached hard drive crashed. Both, I am using as a network attached storage for storing a lot of my data. Fortunately, I was able to restore most of the data. As a lesson-learned from this, I started to look out for a backup solution for my newly set up Raspberry Pi (RPi-Two).

Soon, I found a "nice" backup tool for Debian/Raspbian: [Duplicity](http://duplicity.nongnu.org/). Duplicity has strong support for encrypting backups and is able to use different backends such as [AWS Simple Storage Service (S3)](https://aws.amazon.com/s3/), FTP, etc. Furthermore, Duplicity seemed to be available as a Debian/Raspbian package for a simply installation. Unfortunately, I did not see the following sentences on the Duplicity's main page before I started my setup: "Duplicity is fairly mature software. As any software, it may still have a few bugs [...]. In theory many protocols for connecting to a file server could be supported [...]." (see: [Duplicity](http://duplicity.nongnu.org/))

This post is about my journey finding out about these bugs and, eventually, setting up backups on AWS S3 with Duplicity on my Raspberry Pi built from source.

# Installation Script

# Summary