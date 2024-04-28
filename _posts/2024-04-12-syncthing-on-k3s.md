---
layout: post
date: 2024-04-27 13:40:10 +0100
title: "Deploying Syncthing on a k3s Cluster with Rook"
categories:
  - HowTo
  - Raspberry Pi
  - Syncthing
published: true
hero_image: "/assets/hero-syncthing_on_k3s_with_rook.svg"
---
Roughly four years ago, I have fallen in love with [Syncthing](https://syncthing.net).
First, it was just a partial replacement for [Dropbox](https://www.dropbox.com).
More and more, it grew to be the "data backbone" of my private life.
Recently, I needed to change my Syncthing setup to a Kubernetes-based Syncthing deployment.
So, this article shows how to deploy Syncthing on a Kubernetes cluster with a distributed storage—in my case, this is a three node [k3s](https://k3s.io) cluster running Ceph via [Rook](https://rook.io).

## Introduction and Requirements

Since 2020, I have run Syncthing on a Raspberry Pi 3 Model B storing the data on a 1 terrabyte spinning hard drive which was backed up via [Duplicity](https://duplicity.gitlab.io) (see also: [this article]({% post_url 2020-12-31-duplicity-on-raspberry-pi-from-source %})).
Recently, I have replaced the Raspberry Pi 3 Model B and the spinning hard drive with a three node Raspberry Pi 4 Model B [k3s](https://k3s.io) cluster running [Rook](https://rook.io) as a distributed storage solution.
On this new "lightweight" Kubernetes cluster with Rook, I also wanted to run Syncthing.

However, there were not many tutorials about running Syncthing on Kubernetes.
Essentially, there are a few Syncthing forum entries, a [blog post from Alexandru Scvorțov](https://scvalex.net/posts/53/), and a [blog post from Claus Beerta](https://claus.beerta.net/articles/syncthing-hugo-kubernetes-put-to-work/).
For my specific configuration with k3s and Rook, I have not found a proper tutorial so far.
Furthermore, [Alexandru Scvorțov's setup](https://scvalex.net/posts/53/) uses specific high ports, TCP and UDP port 32222, for Syncthing that are available to [NodePort Kubernetes services](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport)—NodePort services require ports to be in the range of 30000 to 32767.
I would like to use the default ports with my setup.
That is something I did not want. 

All in all, the requirements for my solution are:
 * Run Syncthing on a Kubernetes cluster, k3s, with the distributed storage Rook.
 * In contrast to [Alexandru Scvorțov's setup](https://scvalex.net/posts/53/), I want to use Syncthing's default ports TCP/22000, UDP/22000, and Syncthing's local discovery port UDP/21027.
 * As I am running [a k3s cluster which ships a Traefik Ingress Gateway per default](https://docs.k3s.io/networking/networking-services#traefik-ingress-controller), I want to make use of the Traefik Ingress Gateway for the Syncthing Dashboard and Syncthing ports
 * Additionally, Syncthing's Dashboard should run on HTTPS on a specific path, `https://K3S_CLUSTER_DNS_NAME/syncthing-dashboard/`, as there are further dashboards provided via HTTPS.

The entire Kubernetes deployment descriptors of my setup are available as a [GitHub Gist](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d).
When you download the file `k3s-syncthing.yaml`, you can deploy Syncthing on your own k3s cluster via `kubectl apply -f k3s-syncthing.yaml`.
I rather recommend to modify the deployment descriptors based on your requirements.
In order to understand the setup, we will go through the setup.

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
Furthermore, you also could use services of type `NodePort` instead of `ClusterIP`, so you can directly expose ports in the range of 30000 to 32767.
But as mentioned in [this section](#introduction-and-requirements) already, I want to have the Syncthing standard ports exposed.
In the [next section](#traefik-ingress-controller-modification-for-exposing-standard-syncthing-ports), we will get to this setup which is specific to k3s and its by default installed Traefik Ingress Controller as well as ServiceLB.
When you are happy with Syncthing running on a high port in the range of 30000 to 32767 or do not have a k3s with its Traefik Ingress Controller and its ServiceLB, you can stop with this article and have fun with your setup.

## Traefik Ingress Controller Modification for Exposing Standard Syncthing Ports

As mentioned already, k3s installs a Traefik Ingress Controller and ServiceLB by default.
So, I wanted to use them to expose Syncthing's standard ports.
Also, I wanted to have the Syncthing Dashboard exposed on standard HTTPS port at a specific path, `/syncthing-dashboard/`.
For that, you need, first, to modify k3s' default Traefik Helm Chart configuration to expose further [Traefik EntryPoints](https://doc.traefik.io/traefik/routing/entrypoints/), for Syncthing the ports TCP/22000, UDP/22000, and UDP/21027.
Afterwards, you can bind the `ClusterIP` services via `IngressRoute` resources to those EntryPoints.

Let us start with the modification of k3s' default Traefik Helm Chart configuration.
We can add the EntryPoints via the resource `HelmChartConfig` in the [Gist](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L109).
We simply expose further ports (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L115)).
We add the EntryPoint `syncthing-tcp` at port TCP/22000 (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L119)), the EntryPoint `syncthing-udp` at port UDP/22000 (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L124)), and the EntryPoint `syncthing-disc` at port UDP/21027 (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L129)).
As the standard HTTPS port is exposed anyway, we do not need to add that EntryPoint for Syncthing's Dashboard.

Now, we need to wire the EntryPoints via `IngressRoute` resources to the exposed service ports.
First, we wire the EntryPoint `syncthing-tcp` with the port `syncthing-tcp` of the `ClusterIP` service `syncthing-protocol` via an `IngressRouteTCP` (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L135)).
Second, we connect the EntryPoint `syncthing-udp` with the port `syncthing-udp` of the service `syncthing-protocol` via an `IngressRouteUDP` (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L151)).
Third, we do so with the EntryPoint `syncthing-disc` via an `IngressRouteUDP` (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L166)).

For connecting the HTTPS EntryPoint (name by default: `websecure`), we connect the EntryPoint `websecure` with the port `syncthing-dashboard` of the `ClusterIP` service `syncthing-dashboard` via an `IngressRoute` (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L181)).
As mentioned already, Syncthing's Dashboard should be exposed at `https://K3S_CLUSTER_DNS_NAME/syncthing-dashboard/`.
To achive that, we add a path prefix to the `IngressRoute` (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L194)).
Furthermore, we define a Traefik Middleware to replace the path prefix (see: [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L200) and [here](https://gist.github.com/steffenmueller4/e8ddf4eab6d8910875a47df5d1dbff5d#file-k3s-syncthing-yaml-L204)).

## Architecture Overview

The entire architecture of the Syncthing deployment on my k3s cluster is depicted in the figure below.

![Syncthing Deployment Architecture](/assets/syncthing-deployment-architecture.svg)
