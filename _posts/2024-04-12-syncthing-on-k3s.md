---
layout: post
date: 2024-04-12 15:40:10 +0100
title: "Deploying Syncthing on a k3s Cluster with Rook"
categories:
  - HowTo
  - Raspberry Pi
  - Syncthing
published: true
hero_image: "/assets/hero-syncthing_on_k3s_with_rook.svg"
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
 * In contrast to [Alexandru Scvorțov's setup](https://scvalex.net/posts/53/), I want to use Syncthing's default ports, TCP/22000, UDP/22000, and the Syncthing local discovery port UDP/21
 * As I am running [a k3s cluster which ships a Traefik Ingress Gateway per default](https://docs.k3s.io/networking/networking-services#traefik-ingress-controller), I want to make use of the Traefik Ingress Gateway for the Syncthing Dashboard and Syncthing ports

The entire Kubernetes deployment descriptors are available as a Gist [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d).
When you download the file `k3s-syncthing.yaml`, you can deploy Syncthing on your own k3s cluster via `kubectl apply -f k3s-syncthing.yaml`.
Feel free to modify the deployment descriptors based on your requirements.

In the next sections, we go through the Kubernetes deployment descriptors in detail.
The overall architecture of the entire solution is summarized in [this section](#architecture-overview).

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

One of the most important resources for Syncthing is the Persistent Volume Claim (PVC) and Persistent Volume (PV).
Syncthing stores all the files and its configuration on its storage—per default at `/var/syncthing`.
Without the PV, you lose all your files with every shutdown or restart of the Pod.
For storing Syncthing files and its configuration on a PV, you need a distributed storage on your Kubernetes cluster such as [Rook](https://rook.io/), [Longhorn](https://longhorn.io/), etc.
In my case, this is, as mentioned before, Rook:
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: syncthing-pv-claim
  namespace: syncthing
spec:
  storageClassName: rook-ceph-block
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 100G
```

In the Gist, the PVC declaration starts at [line 9](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L9).
My PVC uses the Kubernetes StorageClass `rook-ceph-block` (see: [line 15](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L15)) which is a Ceph Block Storage with access mode `ReadWriteOnce` (RWO) (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L17), see also: [Ceph Storage documentation](https://rook.io/docs/rook/latest-release/Getting-Started/quickstart/#storage)).
The PVC claims 100 Gigabyte of the Ceph Block Storage.

## Stateful Set / Syncthing Pod

Now, it is time to take care of the Syncthing Pod.
For that, we define the Stateful Set `syncthing`.
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: syncthing
  namespace: syncthing
spec:
  selector:
    matchLabels:
      app: syncthing
  serviceName: syncthing
  replicas: 1
  template:
    metadata:
      labels:
        app: syncthing
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: syncthing
        image: syncthing/syncthing:latest
        ports:
        - name: web-ui
          containerPort: 8384
        - name: syncthing-tcp
          containerPort: 22000
          protocol: TCP
        - name: syncthing-udp
          containerPort: 22000
          protocol: UDP
        - name: syncthing-disc
          containerPort: 21027
          protocol: UDP
        volumeMounts:
        - name: syncthing
          mountPath: /var/syncthing
        env:
        - name: PUID
          value: "1000"
        - name: PGID
          value: "1000"
      volumes:
      - name: syncthing
        persistentVolumeClaim:
          claimName: syncthing-pv-claim
          readOnly: false
```

Due to Syncthing's nature, you should not run more than one Replica (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L33)).
As the Pod binds the PVC, it is a Stateful Set.

The Pod uses always the latest Syncthing release (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L42)).
And it exposes the ports for the Web UI, TCP/8384 (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L44)), for the Syncthing protocol via TCP, TCP/22000 (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L46)), for the Syncthing protocol via QUIC, UDP/22000 (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L49)), and for Syncthing's local discovery protocol, UDP/21027 (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L52)).

The PVC is mounted [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L55) at Syncthing's default storage path `/var/syncthing`, as already explained in [this section](#persistent-volume-claim).

## Services / ClusterIP

In order to expose the Syncthing ports, we use Kubernetes services.

The Syncthing dashboard is exposed via the Service `syncthing-dashboard` of type `ClusterIP` [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L69).
The Service exposes the Syncthing dashboard on port TCP/8384 (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L80)).

The Syncthing protocol ports are exposed via the Service `syncthing-protocol` of type `ClusterIP` [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L84).
The Service exposes the ports TCP/22000 as `syncthing-tcp`, UDP/22000 as `syncthing-udp`, and UDP/21027 as `syncthing-disc`.

Both services could be merged into one specification.
I prefered to keep the dashboard and the protocol Services separated.
Furthermore, you 

## Architecture Overview

The entire architecture of the Syncthing deployment on my k3s cluster is depicted in the figure below.

![Syncthing Deployment Architecture](/assets/syncthing-deployment-architecture.svg)
