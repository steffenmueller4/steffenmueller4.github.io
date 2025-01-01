---
layout: post
date: 2024-12-31 13:15:10 +0100
title: "Modulith Trend - Yes, we are following that trend, too"
categories:
  - Architecture
  - Microservices
  - Modulith
published: true
hero_image: "/assets/hero-modulith_trend.svg"
---
On 2024-12-27, the article "Modular Monolith: Is This the Trend in Software Architecture?" {% cite InfoQ2024 %} of the InfoQ's The Software Architects' Newsletter December 2024 dragged my attention.
Before, my company started a new development effort with renewing the entire site of [HUK-Autowelt](https://www.huk-autowelt.de) (before we were exclusively working on [HUK-Autoservice](https://www.huk-autoservice.de), you can read the stories about that, e.g., [here]({% post_url 2023-08-04-tales-from-a-startup-and-its-evolving-architecture %})).
We will do the renewal/migration of the site one step by step.
The first step was the renewal of the journey to figure out a car's price of potential customers who want to sell their cars to us (car buy journey).
For that, we needed to create a new backend application and went for [Spring Modulith](https://spring.io/projects/spring-modulith), one of the options mentioned in the InfoQ newsletter (see: {% cite InfoQ2024 %}).
This article is about our experiences and our reasons to go for a modular monolith in the new HUK-Autowelt backend.

## Introduction

Some months ago, my company decided to start a new development effort with renewing the site of [HUK-Autowelt](https://www.huk-autowelt.de) (HAW).
Before, my team and me were just working on [HUK-Autoservice](https://www.huk-autoservice.de) (HAG).
I do not want to bore you with all the reasons.
The main reason was to have control over data and the core processes.
This encompasses the integrations of all systems with the core process.

Before, the entire development of HUK-Autowelt—compared to our previous development of HUK-Autoservice, you can read stories about that, e.g., [here]({% post_url 2023-08-04-tales-from-a-startup-and-its-evolving-architecture %})—was done by an external partner.
The external partner did an amazing job and helped us through all the years before.
However, the complexity of our processes and integrations with our internal systems has grown so much in recent years that those processes and integrations have been becoming too complex to be managed properly by all the internal parties (maybe, this is another article soon).
Ineffective and inefficient processes were the result.

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autowelt](https://www.huk-autowelt.de) for the awesome work.