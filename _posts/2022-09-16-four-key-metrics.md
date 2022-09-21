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
hero_image: "/assets/hero_learnings_from_building_an_edma.svg"
---
When I started as an engineering manager in a team at a former employer a couple of years ago, the team I joined performed deployments after a sprint has ended every two weeks.
The preparation of the deployment and the deployment took regularly two engineers a full day of work.
So, the overhead was huge, the work was repetitive, and no engineer really wanted to do that job.
Since that point in time, I am a huge fan of the practices proclaimed by the Accelerate book {% cite Forsgren2018 %} and the [State of DevOps report](https://www.devops-research.com/research.html#reports).
I always educate my teams to follow those practices as much as possible.
This articles is about how my current team is working with those practices and the famous [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298) to get to an excellent development environment which allows us to deploy to production regularly within about five minutes.

## Introduction

> Disclaimer: This article presents my personal opinions and perspectives on the project, so this is not my company's opinion.

Now, it is roughly one year ago since my peer, Moritz (head of product), and me started with the rewrite of the web application of my company (see also: [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %})).
To be honest, the start of the project was, let us call it, shaky.
Before the first Site Reliability Engineer joined the team in November, I was creating the infrastructure, the CI/CD pipelines, etc. to the best that I could.
When I look at the project now, we have established a cool setup that allows us to push code changes to production in about five minutes all lead by the famous [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298).

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