---
layout: post
date:   2022-09-16 14:01:20 +0100
title: "With Four Key Metrics to Operational Development Excellence"
categories:
  - DevOps
  - KPI
  - Development
  - Culture
published: true
hero_image: "/assets/hero-four_key_metrics.svg"
---
In a nice article about why technology matters more and more for companies, Gary O'Brien and Mike Mason mention Continous Delivery (CD) and applied DevOps practices as one of five key factors for a company's success {% cite OBrien2020 %}.
Also Jon Moore and Marty Cagan speak in {% cite Moore2022 %} and {% cite Moore2022a %} about the importance of changing the how you build and deploy.
It is essential to be able to shift from a slow and lengthy release cycles to a fast and incremental/iterative approach to be successful in developing a software product.
This articles is about my experience with CI/CD and the DevOps practices as well as how my current team uses the famous [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298) to get to an excellent development environment which allows us to deploy to production regularly within about five minutes.

## Introduction

> Disclaimer: This article presents my personal opinions and perspectives on the project, so this is not my company's opinion.

When I started as an engineering manager at a former employer in 2018, the team which I joined ran deployments of its software product after every sprint every two weeks.
Major issue, however, was that the deployment took regularly two engineers a full day of work.
The entire deployment process was error-prone, a huge overhead, and enormously repetitive.
Essentially, no engineer really wanted to do the job that was assigned by lot.
Although I experienced lengthy or difficult deployment processes in my career before and also in later career steps, that process was really a nightmare and needed to be changed.

Since that point, I am a huge fan of the practices proclaimed by the book Accelerate {% cite Forsgren2018 %} and the entire [DevOps Research & Assessment (DORA)](https://www.devops-research.com) program and its outcome, the [State of DevOps report](https://www.devops-research.com/research.html#reports).
Simply, a deployment has to be the most natural thing in the world for the developers.
New features should be shipped via fully automated processes in nearly no time to production, so that there is no overhead and can be done with every feature that has been finished or bug that has been fixed.
Nowadays, also the term "developer experience" is connected to that requirement (see also: {% cite Tiedemann2021 %}).

But not only the developer experience and satisfaction—so rather the internal view—is improved by these practices, there are a lot of other effects why those practices may help you to achieve operational excellence.
Jon Moore and Marty Cagan summarize the effects nicely in {% cite Moore2022a %}:
 - TODO
 - TODO

Jacob Bo Tiedemann and Tanja Bach come to a very catchy summary in {% cite Tiedemann2021 %} when not adhering to the practices: "You are losing money".

## A Glimpse on the Technical Setup

When I look at [ThoughWorks' Technology Radar Vol. 26](https://www.thoughtworks.com/content/dam/thoughtworks/documents/radar/2022/03/tr_technology_radar_vol_26_en.pdf), I could be quite proud ;-) that we have a couple of up-to-date technologies, platforms, tools, and languages & frameworks in our project.
From the beginning, we are using [GitHub Actions](https://github.com/features/actions), Kotest, etc.
Nowadays, we are also watching at [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298) and a dashboard showing us the change-lead time as well as the deployment frequency.

As written: I *could* be quite proud.
But just using up-to-date technology and announcing four further KPIs would not really lead to anything but to a Hype-driven Development (HDD).
Anyway, let's start at the beginning.

In August/October 2021, my peer, Moritz (head of product Autoservice), and me started with the rewrite of the web application of my company (see also: [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %})).
To be honest, the start of the project was, let us call it, shaky.
Before the first Site Reliability Engineer joined the team in November, I was creating the infrastructure, the CI/CD pipelines, etc. to the best that I could.
I created a Kubernetes (K8s) cluster and a few repositories as well as some Github Actions to deploy the code to the K8s cluster.

The general setup has improved a lot in one year.
When a developer creates a pull request (PR), linting is performed, a new container is build and deployed, end-2-end (e2e) tests are run, etc.
As soon as the PR is merged to the main branch, a newly build container is deployed to our development cluster and, when the e2e test are green, it is deployed to next stage.
There the new container can be tested manually and, after approval, deployed to production in roughly 5 min.

Overall, I think a good setup.

## Four Key Metrics

todo

## References

{% bibliography --cited %}