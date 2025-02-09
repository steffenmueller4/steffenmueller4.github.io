---
layout: post
date: 2024-12-31 13:15:10 +0100
title: "Trend: Moduliths - Why we follow it, too"
categories:
  - Architecture
  - Microservices
  - Modulith
published: true
hero_image: "/assets/hero-modulith_trend.svg"
---
On 2024-12-27, the article "Modular Monolith: Is This the Trend in Software Architecture?" {% cite InfoQ2024 %} of the InfoQ's The Software Architects' Newsletter December 2024 dragged my attention.
Simple reason is that my company started a new development endeavor with renewing the entire site of [HUK-Autowelt](https://www.huk-autowelt.de) (before we were working on [HUK-Autoservice](https://www.huk-autoservice.de) exclusively, you can read the stories about that, e.g., [here]({% post_url 2023-08-04-tales-from-a-startup-and-its-evolving-architecture %})), and we are also following the modular monolith approach with the new endeavor.
We will do the renewal of the site step by step.
The first step was the renewal of the journey to figure out a car's price of potential customers who want to sell their cars to us (car buy journey [here](https://bewertung.huk-autowelt.de)).
For the new backend application, we are using [Spring Modulith](https://spring.io/projects/spring-modulith), one of the options mentioned in the InfoQ newsletter (see: {% cite InfoQ2024 %}).
This article is about our experiences and our reasons to go for a modular monolith in the new HUK-Autowelt backend.

## Background

In October 2024, my company, HUK-COBURG Autowelt GmbH (HUK-Autowelt), decided to start a new development endeavor with renewing the site of [HUK-Autowelt](https://www.huk-autowelt.de).
I do not want to bore you with all the details of the decision.
The main reason was to have control over data and core processes of the company.
This encompasses the integrations of all systems with the core process.

Before, the entire development of HUK-Autowelt—compared to our previous development of HUK-Autoservice; you can read stories about that, e.g., [here]({% post_url 2023-08-04-tales-from-a-startup-and-its-evolving-architecture %})—was done by an external partner.
The external partner has done an amazing job and helped us through all the years before.
However, the complexity of our processes and integrations with our internal systems has grown so much in recent years that those processes and integrations have been becoming enormously complex (maybe, this is another article soon).
The results were ineffective and inefficient processes as well as nobody being able to overlook the processes and challenges when changing them.

Besides the decision about the new development endeavor with HUK-Autowelt, we also have to cope with the additional challenge of a smaller development team compared to the previous development team in HUK-Autoservice.
As we are not different to other companies, we also have to handle the "new reality" in tech industry: the "[...] demise of 0% interest rates [...]" {% cite Orosz2024 %}.
This simply means that we have to consider Total Cost of Ownership (TCO) for our development endeavors again and providing short term positive cash flow.
As a result, we had to reduce the development team size compared to the HUK-Autoservice development team where we peaked with 15 developers.
Fortunately, we were able to shrink organically without layoffs.

## What is a Modular Monolith/Modulith?

In general, modular monoliths (moduliths) want to combine the benefits of monoliths and microservices {% cite Su2024 %}.
The major benefit of microservices is the independent deployability and scalability of microservices.
The major benefit of monoliths compared to microservices is the easier maintainability.
The syntheses is bad deployability and bad maintainability—oh, wait... wrong :-)—of course, we want to achieve the modularity of microservices and the easier maintainability.
The modularity should be achieved via encapsulating domains.
The maintainability should be supported by having those encapsulated modules in a monolithic architecture.

Let us examine a short example about the difficulites about maintaining multiple microservices:
When we developed the environment for HUK-Autoservice, we started with two teams.
Both teams developed an essential part of HUK-Autoservice: [we developed a core backend for the booking process and an account backend]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}).
Over the years, we have grown further teams, then merged teams, and essentially have come up with just one development team.
But the microservices architecture with core backend and an account backed stayed even with one team.
We maintained both microservices, but changes that required updates in both microservices, were quite difficult to team members: A pull request to the first repository, a pull request to a common library that is used for Kafka messages, and a pull request to the account microservice and/or further microservices.
On top, we often had to coordinate the rollouts of those three pull requests.

With the new development endeavor, we decided to use [Spring Modulith](https://spring.io/projects/spring-modulith) to ease our development within the small team.
For now, we will stay with just one development team.
Specifically, working with events—we did this manually before via Kafka—is much easier with Spring Modulith.
A good tutorial to learn about Spring Modulith is available at [baeldung.com](https://www.baeldung.com/spring-modulith).

## What benefits does a Modulith bring us?

For us, the major benefit of a modulith is the better maintainability.
We have just one development team.
This team does not need to work in different repositories and applications, so nobody has to create pull requests in different repositories.
We, additionally, do not have to coordinate rollouts of pull requests.
There is just one application and one setup.

Furthermore, 

## Summary

Todo

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autowelt](https://www.huk-autowelt.de) for the awesome work.