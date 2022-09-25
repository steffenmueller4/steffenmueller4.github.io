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

Since that point, I am a huge fan of the practices proclaimed by the book Accelerate by Nicole Forsgren {% cite Forsgren2018 %} and the entire [DevOps Research & Assessment (DORA)](https://www.devops-research.com) program and its outcome, the [State of DevOps report](https://www.devops-research.com/research.html#reports).
Simply, a deployment has to be the most natural thing in the world for the developers.
New features should be shipped via fully automated processes in nearly no time to production, so that there is no overhead and can be done with every feature that has been finished or bug that has been fixed.
Nowadays, also the term "developer experience" is connected to that goal (see also: {% cite Tiedemann2021 %}).
As developers and their "experience" are the essential to build your digital product, they should be able to do their work as effectively as possible, otherwise you are loosing money essentially (see:  {% cite Moore2022a %}, {% cite Tiedemann2021 %}, and {% cite Forsgren2018 %}).

According to the latest [State of DevOps report 2021](https://cloud.google.com/devops/state-of-devops) {% cite Smith2021 %}, "[...] excellence in software delivery and operational performance drives organizational performance in technology transformations." {% cite Smith2021 %}
While previous reports have only seen a relationship that companies with a good organizational performance have had a good performance in software delivery (see: {% cite %}), it now seems become clearer that also companies concentrating on improving their CD and software delivery performance can also improve their organizational performance (see, e.g.: [State of DevOps report 2019](https://cloud.google.com/devops/state-of-devops) {% cite Forsgren2019 %}).
The [State of DevOps report 2019](https://cloud.google.com/devops/state-of-devops) summarizes that
their "[...] research continues to show that the industry-standard Four Key Metrics of software development and delivery drive organizational performance in technology transformations [...] [It] revalidates previous findings that it is possible to optimize for stability without sacrificing speed." {% cite Forsgren2019 %}

So, with the start of the development of the product at my current employer in August/October 2021 (see also: [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %})), we directly focused on a proper CD and software delivery performance.
Recently, we also started to measure the first metrics of the [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298), the Change Lead Time and Deployment Frequency.

The remainder of this article concentrates on showing you how we did this.
Additionally, I will try to give you insights on the positive effects of all those efforts.
[In the next section](#a-glimpse-on-the-technical-setup), we will look at the general technical setup that we have.

## A Glimpse on the Technical Setup

When looking at the current [ThoughWorks' Technology Radar Vol. 26](https://www.thoughtworks.com/content/dam/thoughtworks/documents/radar/2022/03/tr_technology_radar_vol_26_en.pdf), my team and me could be quite proud ;-) that we have a couple of up-to-date technologies, platforms, tools, and languages & frameworks in our project.
But just using up-to-date technology does not really lead us anywhere but to a Hype-driven Development.
Let us concentrate on the essential tech setup in the following.

The basis of our entire technical setup is that we mostly follow [Trunk-based Development](https://cloud.google.com/architecture/devops/devops-tech-trunk-based-development) with GIT.
Trunk-based Development bases on using feature branches as well as working in small batches that are merged as soon as and as often as possible.
The [State of DevOps report 2021](https://cloud.google.com/devops/state-of-devops) counts Trunk-based Development as one of the core capabilities that drives higher software delivery and organizational performance.

While insisting on Trunk-based Development, I always have had a lot of discussions.
Many team members now and back then in other teams at other employers, rather wanted to follow strategies such as GIT-Flow or other non-trunk-based development styles.
Especially, when there was a Quality Assurance (QA) team, the wish to practice Trunk-based Development was oftentimes not achievable due to the QAs wanting to check every change before deployment.

As I agree that sometimes it is hard to 100% follow Trunk-based Development purely, we realized so-called PR Deployments.
In order to review Pull Requests (PR), it can help to deploy the  temporarily.
(see also: {% cite Thiel2021 %})



The general setup has improved a lot in one year.
When a developer creates a pull request (PR), linting is performed, a new container is build and deployed, end-2-end (e2e) tests are run, etc.
As soon as the PR is merged to the main branch, a newly build container is deployed to our development cluster and, when the e2e test are green, it is deployed to next stage.
There the new container can be tested manually and, after approval, deployed to production in roughly 5 min.

Overall, I think a good setup.

## Four Key Metrics

todo

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autoservice](https://www.huk-autoservice.de) as well as [foobar Agency GmbH](https://foobar.agency) for the awesome work.
Specifically, I would like to thank Dario Segger for the tremendous work on the measurement of the [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298) as well as building the depicted dashboards.