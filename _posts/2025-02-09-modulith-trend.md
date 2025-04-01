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
On 2024-12-27, the article "Modular Monolith: Is This the Trend in Software Architecture?" {% cite InfoQ2024 %} in InfoQ's *The Software Architects' Newsletter* caught my attention.
The reason is simple: my team and I recently embarked on a new development endeavor to renew the entire site of [HUK-Autowelt](https://www.huk-autowelt.de).
Previously, we worked on [HUK-Autoservice](https://www.huk-autoservice.de), and you can read about that journey [here]({% post_url 2023-08-04-tales-from-a-startup-and-its-evolving-architecture %}). For this new project, we are also adopting the modular monolith approach.
The renewal of the site will be done step by step.
The first milestone was revamping the car-buying journey, which allows customers to determine the price of their cars ([car buy journey](https://bewertung.huk-autowelt.de)).
For the new backend application, we chose [Spring Modulith](https://spring.io/projects/spring-modulith), one of the options highlighted in the InfoQ newsletter (see: {% cite InfoQ2024 %}). 
This article shares our experiences and explains why we opted for a modular monolith for the new backend.

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

To understand why a modulith is an improvement for us, let us examine a short example of the difficulties in maintaining multiple microservices:
When we developed the HUK-Autoservice, we started with two development teams.
Both teams developed essential parts of HUK-Autoservice: [we developed a core backend to run the booking process as well as an account backend to manage everything related to user accounts]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}).
Over the years, we grew additional teams, then merged teams, and eventually ended up with just one development team.
However, the microservices architecture—with the core backend, account backend, and additional microservices—remained in place, even with just one team.
We maintained the microservices, but changes requiring updates in two or more microservices were quite challenging for the team members.
Such updates, for example, looked like: A pull request to the core backend repository, a pull request to a common library for the Kafka messages used to have a common message definition in all Kafka producers and consumers, and a pull request to the account backend repository.
On top of that, we often had to coordinate rollouts for these pull requests.

For us, the major benefit of a modulith is the enhanced maintainability.
As explained above, we now have just one development team, one application for HUK-Autowelt, and just one repository.
Working across multiple repositories and applications as well as creating pull requests in different repositories, had been a significant burden for us for a long time.

## Technical Side of Moduliths

With the new development endeavor, we decided to use [Spring Modulith](https://spring.io/projects/spring-modulith) to simplify our development process within the smaller team.
For now, we will stick with just one development team.
Specifically, working with events—which we previously handled manually via Kafka—is much easier with Spring Modulith.
A good tutorial to learn about Spring Modulith is available at [baeldung.com](https://www.baeldung.com/spring-modulith).

## Summary

Todo

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autowelt](https://www.huk-autowelt.de) for the awesome work.