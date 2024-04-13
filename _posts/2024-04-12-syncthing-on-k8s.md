---
layout: post
date:   2024-04-12 15:40:10 +0100
title: "Deploying Syncthing on a k3s Cluster with Rook"
categories:
  - HowTo
  - Raspberry Pi
  - Tech
published: true
hero_image: "/assets/hero-tales_from_startup_and_its_evolving_architecture.svg"
---
Roughly four years ago, I have fallen in love with [Syncthing](https://syncthing.net).
First, it was just a partial replacement for Dropbox I just wanted to try out.
More and more, it grew to be the "data backbone" of my private life.
This article shows how to deploy Syncthing on a Kubernetes cluster with a distributed storage—in my case, this is a three node [k3s](https://k3s.io/) cluster running [Rook](https://rook.io/).

## Introduction and Requirements

Since 2020, I have run Syncthing on a Raspberry Pi 3 Model B storing the data on a 1 terrabyte spinning hard drive which was backed up via [Duplicity](https://duplicity.gitlab.io/) (see also: [this article]({% post_url 2020-12-31-duplicity-on-raspberry-pi-from-source %})).
Recently, I have replaced the Raspberry Pi 3 Model B and the spinning HDD with a three node Raspberry Pi 4 Model B [k3s](https://k3s.io/) cluster where I installed [Rook](https://rook.io/) as a distributed storage solution.
On this new "lightweight" Kubernetes cluster with Rook, I also wanted to run Syncthing.

There are not many tutorials about running Syncthing on Kubernetes.
Essentially, there are a few Syncthing forum entries, a [blog post from Alexandru Scvorțov](https://scvalex.net/posts/53/), and a [blog post from Claus Beerta](https://claus.beerta.net/articles/syncthing-hugo-kubernetes-put-to-work/).
For my specific configuration with k3s and Rook, I have not found a proper tutorial so far.
Thereby, Alexandru Scvorțov uses specific high ports, TCP and UDP port 32222, for Syncthing that are available to [NodePort Kubernetes services](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport)—NodePort services require ports to be in the range of 30000 to 32767.
I would like to use the default ports with my setup.

The requirements for my solution are:
 * Run Syncthing on a Kubernetes cluster with a distributed storage
 * Storing the data with the distributed Kubernetes storage
 * In contrast to Alexandru Scvorțov with his setup [here](https://scvalex.net/posts/53/), I want to use Syncthing's default ports

## Namespace

I recommend, placing all resources required for Syncthing into a new namespace in the Kubernetes cluster.
In the following, we will use the namespace `syncthing`.
We achieve this, via creating the following YAML and run `kubectl apply -f namespace.yaml`.

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: syncthing
  labels:
    name: syncthing
```

## Persistence Volume Claim

