---
layout: post
date: 2024-04-12 15:40:10 +0100
title: "Deploying Syncthing on a k3s Cluster with Rook"
categories:
  - HowTo
  - Raspberry Pi
  - Syncthing
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
 * Run Syncthing on a Kubernetes cluster with the distributed storage Rook
 * In contrast to Alexandru Scvorțov with his setup [here](https://scvalex.net/posts/53/), I want to use Syncthing's default ports
 * As I am running a k3s cluster which deploys a Traefik Ingress Gateway per default, I wanted to make use of the Traefik Ingress Gateway for the Syncthing Dashboard and Syncthing ports

The entire Kubernetes deployment descriptors are available as a Gist [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d).
When you download the file `k3s-syncthing.yaml`, you can deploy Syncthing on your own k3s cluster via `kubectl apply -f k3s-syncthing.yaml`.
Feel free to modify the deployment descriptors based on your requirements.

In the next sections, we go through the Kubernetes deployment descriptors in detail.

## Namespace

All the resources for Syncthing in the [Gist](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d) are placed in the namespace `syncthing`.
The namespace is the first resource created at [line 2](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L2):

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: syncthing
  labels:
    name: syncthing
```

## Persistent Volume Claim

One of the most important resources for Syncthing is the Persistent Volume Claim (PVC).
Syncthing stores all the files and its configuration on its storage—per default at `/var/syncthing`.
Without the Persistent Volume (PV), you lose all your files with every restart of the Pod.
For storing Syncthing files and its configuration on a PV, you need a distributed storage on your Kubernetes cluster such as [Rook](https://rook.io/), [Longhorn](https://longhorn.io/), etc.
In my case, this is, as mentioned before, Rook.

In the Gist, the PVC declaration starts at [line 9](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L9).
My PVC uses the Kubernetes StorageClass `rook-ceph-block` (see also: [line 15](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L15)) which is a Ceph Block Storage with access mode `ReadWriteOnce` (RWO) (see also: [Ceph Storage documentation](https://rook.io/docs/rook/latest-release/Getting-Started/quickstart/#storage)).