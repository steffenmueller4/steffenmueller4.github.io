---
layout: post
date: 2025-02-09 10:15:10 +0100
title: "Trend: Moduliths - Why we follow it, too"
categories:
  - Architecture
  - Microservices
  - Modulith
published: true
hero_image: "/assets/hero-modulith_trend.svg"
---
On 2024-12-27, the article "Modular Monolith: Is This the Trend in Software Architecture?" {% cite InfoQ2024 %} of the InfoQ's The Software Architects' Newsletter December 2024 dragged my attention.
Simple reason is that my team and me started a new development endeavor with renewing the entire site of [HUK-Autowelt](https://www.huk-autowelt.de) (before we were working on [HUK-Autoservice](https://www.huk-autoservice.de), you can read the stories about that, e.g., [here]({% post_url 2023-08-04-tales-from-a-startup-and-its-evolving-architecture %})), and we are also following the modular monolith approach with the new endeavor.
We will do the renewal of the site step by step.
The first step was the renewal of the journey to figure out a car's price of potential customers who want to sell their cars to us (car buy journey, [here](https://bewertung.huk-autowelt.de)).
For the new backend application, we are using [Spring Modulith](https://spring.io/projects/spring-modulith), one of the options mentioned in the InfoQ newsletter (see: {% cite InfoQ2024 %}).
This article is about our experiences and our reasons to go for a modular monolith in the new backend.

## Background

In October 2024, we decided to start a new development endeavor with renewing the site of [HUK-Autowelt](https://www.huk-autowelt.de).
The main reason was to have control over data and all the core processes.
This encompasses the renewal of all customer-facing application, the integrations of all systems in the background, and the core processes connected to those applications and systems.

Before, the entire development of HUK-Autowelt—compared to our previous development endeavor of HUK-Autoservice; you can read stories about that, e.g., [here]({% post_url 2023-08-04-tales-from-a-startup-and-its-evolving-architecture %})—was done by an external partner.
The partner has done an amazing job and has driven our business all the years before.
However, the complexity of our processes and integrations with our internal systems has grown so much in recent years that those processes and integrations have been becoming enormously complex (maybe, this is another article soon).
The results were ineffective and inefficient processes as well as nobody being able to overlook the processes and challenges when changing them.

Besides the decision about the new development endeavor, we also have to cope with the additional challenge of a smaller development team compared to the previous development team in HUK-Autoservice.
As we are not different to other companies, we also have to handle the "new reality" in tech industry: the "[...] demise of 0% interest rates [...]" {% cite Orosz2024 %}.
This simply means that we must reconsider Total Cost of Ownership for our select development and provide short term positive cash flow contrary to previous development activities.
As a result, we had to reduce the development team compared to before where we peaked with 15 developers in different sub-teams.
Now, we are just running one development team—we have already merged some time ago.
And, fortunately, we have been able to shrink development team size organically without layoffs.

The smaller team has also required the adaptation of our previous approach of microservices per domain connected via message queues that we used before.
We now use the modular monolith—or short "modulith"—approach.
This article explains the background of moduliths, why we have chosen that when starting the new development endeavor, and our first experiences.

## What is a Modular Monolith/Modulith?

In general, modular monoliths (in short: moduliths) are a software architecture pattern that wants to combine the benefits of monoliths and microservices {% cite Su2024 %}, {% cite Su2023 %}.
Here, "monolith" or "monolithic" means that the software is composed all in one piece—somehow like one "executable" or "runnable".
While previously tiering and layering (tiers such as application server or database; layers such as presentation, business, and data access layer) have been used in monolithic architectures, the basic idea of a modulith is now to structure a monolith into modules (modularization).

Thereby, modularization is not a new concept in software architecture but in moduliths, modularization is key to being able to achieve maintainability by different teams in the monolith {% cite Su2024 %}, {% cite Su2023 %}.
Modules should be loosely coupled as well as have clear boundaries and well-defined dependencies on other modules.
The goal of modularization in moduliths is indepencence and isolation of each module.
The modules should focus on business domains comparable to proper microservices design, and, ideally, they can be migrated to microservices if indepentent deployability or scalability is needed.

The major benefit of monoliths is the enhanced maintainability/less complexity and, thus, often faster development speed, because a monolith is a less distributed software system compared to microservices where different domains are separated into different microservices.
The major benefits of microservices is scalability, independent deployability, and modularity (if you design them properly via, e.g., separating domains; see also: [here]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}) or {% cite Newman2019 %}).

Thus, a modulith comprises bad deployability and bad maintainability—oh... wrong me ;-)—of course, we want to achieve modularity comparable to microservices as well as enhanced maintainability/less complexity due to a less distributed system such as in monoliths {% cite Su2024 %}, {% cite Su2023 %}.
The modularity can be achieved via splitting the system into separate modules, not only in layers.
The easier maintainability can be supported by having those encapsulated modules in a monolithic architecture, not in microservices.

In sum, moduliths is an architectural style that is a different approach between monolithic and microservices architectures.
Su et al. in {% cite Su2024 %} summarize the characteristics of moduliths as:
 * They have separate and independent modules with a clear own domain and autonomy from other modules.
 * They should be loosely coupled between modules and should have strong cohesion inside a module. Communication between modules should happen through well-defined API or asynchronously via message brokers.
 * They have a unified database schema contrary to microservices where every microservice should have its own database schema (see also: {% cite Newman2019 %}).
 * They have a monolithic deployement structure and are deployed as one application.
 * They have a unified application process similar to monoliths.
 * They have enhanced maintainability.

In the next section, let us look at the benefits a modulith brings to my team and me and to why we have chosen this architectural style over microservices now.

## What benefits does a Modulith bring to us?

To understand why a modulith is an improvement to us, let us examine a short example about the difficulites of maintaining multiple microservices:
When we developed the environment for HUK-Autoservice, we started with two teams.
Both teams developed an essential part of HUK-Autoservice: [we developed a core backend to run the booking process as well as an account backend to run everything about accounts of users]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}).
Over the years, we have grown further teams, then merged teams, and essentially have come up with just one development team.
But the microservices architecture with core backend, account backed, and further microservices stayed even with one team.
We maintained the microservices, but changes that required updates in two or more microservices, were quite difficult to the team members: A pull request to the core backend repository, a pull request to a common library that is used for Kafka messages, and a pull request to the account backend repositoriy and/or further microservices.
On top, we often had to coordinate rollouts of those pull requests.

For us, the major benefit of a modulith is the enhanced maintainability.
As explained above, we just have one joint development team, one application in HUK-Autowelt, and just one repository.
Working in different repositories and applications as well as making pull requests in different repositories has been rather a burden for us for a long time.

With the new development endeavor, we decided to use [Spring Modulith](https://spring.io/projects/spring-modulith) to ease our development within the small team.
For now, we will stay with just one development team.
Specifically, working with events—we did this manually before via Kafka—is much easier with Spring Modulith.
A good tutorial to learn about Spring Modulith is available at [baeldung.com](https://www.baeldung.com/spring-modulith).

## Summary

Todo

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autowelt](https://www.huk-autowelt.de) for the awesome work.