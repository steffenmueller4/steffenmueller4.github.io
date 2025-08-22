---
layout: post
date: 2025-05-16 09:15:10 +0100
title: "Good and Bad Decisions in the Tech Team in Hindsight"
categories:
  - Architecture
  - Microservices
  - Modular Monolith
published: true
hero_image: "/assets/hero-modulith_trend.svg"
---
In the last article about the decision to use a [Modular Monolith]({% post_url 2025-04-06-modulith-trend %}) in a new development endeavor with the team, you may have read already that my team and the company I work at has gone through a massive transformation recently.
In August 2024, the decision has been made that my team and me are not going to develop on [HUK-Autoservice](https://www.huk-autoservice.de) further.
We decided to start a new development endeavor to renew the entire site of [HUK-Autowelt](https://www.huk-autowelt.de).
In the beginning of 2025, we have transferred the domain and all the development of HUK-Autoservice to [pitstop, another subsidiary that HUK has bought before in November 2024](https://www.spiegel.de/wirtschaft/service/huk-coburg-uebernimmt-werkstattkette-pitstop-a-41dc8155-af42-4677-93f4-b664d68065a3).
This radical transformation with a new development endeavor gave us the chance to rethink the development setup.
In this article, I will go through some good and some decisions in the development of HUK-Autoservice in hindsight as eight more or less self-contained short stories.

## Introduction

ToDo

## Build a Platform maintained by the DevOps team

When we started in 2021, I was influenced by the books Accelerate {% cite Forsgren2018 %} and Team Topologies {% cite Skelton2019 %}.
This lead to the situation that we set up a DevOps (sub-)team taking care of a "platform" the developers used to develop and run their applications on.

The "platform" consisted and still does in our new development endeavor of diverse platform capabilites and platform interfaces based on AWS, Github, and Atlassian services the (sub-)team was providing to the developers.
This approach allowed us—and still does—to run fast.
Back then, the term "platform engineering" coined by the CNCF was not yet known.
In hindsight, the decision to build and run such a "platform" was absolutely right and, thus, good.

## Differentiate between Front-, Back-End, and DevOps

When we started in 2021, I had a lot of discussions about going full-stack or going with dedicated back-end, front-end, and devops engineers.
Although, there are a lot of good reasons why a start-up should strive for unifying their workforce via full-stack engineers to better allocate work packages, we decided to work with dedicated back-end, front-end, and devops engineers instead of going full-stack.

My simple reason to split the functions was simply: there is no allrounder who is capable of doing everything well, so I am rather a friend of clear boundaries and responsibilities.
1) front-end engineers create the user interface (UI) which is subject of most discussions in customer-facing products and none-tech companies.
It is something everybody sees and everybody has an opinion about it.
So, they have to make the product, design, and user experience team happy.
And they should not bear the complexity of dealing with other API and systems integration challenges we need in order to achieve the front-end functionalities.
2) back-end engineers have to create the API that the front-end engineers use to do their work.
Also, they have to do the systems integration work on the other end such as working with partner API, integrating ERP systems, etc.
3) the devops engineers maintain the platform that run the code of the front-end and back-end engineers (see also: [this section](#build-a-platform-maintained-by-the-devops-team)).

In retrospect, this decision was right, and let us move quickly in all our scenarios.
Especially, in our new development endeavor with [HUK-Autowelt](https://www.huk-autowelt.de), this is the best decision in hindsight: The internal processes to rate a car, to create a contract when customers sell their car to us, to track the car for logistics, etc. require a lot of work to integrate different systems.
And that is nothing you can do easily when also dealing with design and user experience challenges.

## Not managing State in the Kubernetes Cluster



## Focus on Software Development Performance

## Using Microservices Architecture Pattern

## Using Good Ol' Technologies in the "Startup" Context

## Less Focus on Data Management

## Less Focus on Documentation

## Summary

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autowelt](https://www.huk-autowelt.de) for their outstanding work.