---
layout: post
date: 2025-02-09 10:15:10 +0100
title: "Trend Modular Monolith - Why We Follow the Trend, Too"
categories:
  - Architecture
  - Microservices
  - Modular Monolith
published: true
hero_image: "/assets/hero-modulith_trend.svg"
---
On 2024-12-27, the article "Modular Monolith: Is This the Trend in Software Architecture?" {% cite InfoQ2024 %} in InfoQ's *The Software Architects' Newsletter* caught my attention.
The reason is simple: my team and I recently embarked on a new development endeavor to renew the entire site of [HUK-Autowelt](https://www.huk-autowelt.de).
Previously, we worked on [HUK-Autoservice](https://www.huk-autoservice.de), and you can read about that journey [here]({% post_url 2023-08-04-tales-from-a-startup-and-its-evolving-architecture %}).
For this new project, we are also adopting the modular monolith approach.
The first milestone of the project was revamping the car-buying journey, which allows customers to determine the price of their cars ([car-buying journey](https://bewertung.huk-autowelt.de)).
For the new backend application, we chose [Spring Modulith](https://spring.io/projects/spring-modulith), one of the options highlighted in the InfoQ newsletter (see: {% cite InfoQ2024 %}).
This article shares our experiences and explains why we opted for a modular monolith for the new backend.

## Background

In October 2024, we decided to start a new development endeavor to renew the site of [HUK-Autowelt](https://www.huk-autowelt.de).
The main reason was to gain control over our data and core processes.
This encompasses the renewal of all customer-facing applications, the integration of all background systems, and the core processes connected to those applications and systems.

Previously, the entire development of HUK-Autowelt—unlike our earlier development of HUK-Autoservice (you can read about that [here]({% post_url 2023-08-04-tales-from-a-startup-and-its-evolving-architecture %}))—was handled by an external partner.
While the partner did an excellent job and supported our business for many years, the growing complexity of our processes and integrations with internal systems made it increasingly difficult to manage.
This complexity led to inefficient processes and challenges in making changes.

In addition to starting this new development endeavor, we faced the challenge of working with a smaller development team compared to the one we had for HUK-Autoservice.
Like many other companies, we had to adapt to the "new reality" in the tech industry: the "[...] demise of 0% interest rates [...]" {% cite Orosz2024 %}.
This required us to reconsider the Total Cost of Ownership for our development efforts and focus on achieving short-term positive cash flow.
As a result, we reduced our development team size compared to before where we peaked with 15 developers in different sub-teams.
Now, we are just running one development team.
Fortunately, we managed this reduction organically without layoffs.

The smaller team also necessitated a shift in our architectural approach.
Previously, we used microservices per domain connected via message queues.
Now, we have adopted the modular monolith—or "modulith"—approach.
This article explains the concept of moduliths, why we chose this architecture for our new development endeavor, and our initial experiences.

## What is a Modular Monolith/Modulith?

A modular monolith, or modulith, is a software architecture pattern that combines the benefits of monoliths and microservices {% cite Su2024 %}, {% cite Su2023 %}.
In this context, "monolith" refers to software composed as a single, unified application—similar to one "executable" or "runnable".
While traditional monolithic architectures often relied on tiers and layers (tiers such as application server or database; layers such as presentation, business, and data access layer), a modulith emphasizes on modularizing a monolith.

Modularization is not a new concept in software architecture.
In moduliths, it is, however, a key principle for achieving maintainability by different teams in the monolith {% cite Su2024 %}, {% cite Su2023 %}.
Modules should be loosely coupled, have clear boundaries, and define dependencies explicitly.
The goal of modularization in moduliths is indepencence and isolation of each module.
Ideally, these modules align with business domains, similar to microservices design, and can be migrated to microservices if independent deployability or scalability becomes necessary.

The primary advantage of monoliths is their enhanced maintainability/less complexity, as they are less distributed than microservices.
This often results in faster development speeds.
On the other hand, microservices offer scalability, independent deployability, and modularity—when they are designed properly, e.g., by separating domains {% cite Newman2019 %}.

In sum, moduliths is an architectural style that is a different approach between monolithic and microservices architectures.
Key characteristics of moduliths include {% cite Su2024 %}, {% cite Su2023 %}:
- Separate and independent modules with clear domains and autonomy from other modules.
- Loose coupling between modules and strong cohesion within modules. Communication between modules occurs through well-defined APIs or asynchronously via message brokers.
- A unified database schema—unlike microservices where each service should have its own schema {% cite Newman2019 %}.
- A unified application process similar to monoliths.
- Enhanced maintainability due to the encapsulation of modules within a monolithic architecture.

## What Benefits Does a Modulith Bring to Us?

The modulith has significantly improved our development processes.
When we developed HUK-Autoservice, we started with two development teams.
Having two microservices, was necessary to be able to deploy independently.
Over time, we grew additional teams, merged them, and eventually ended up with just one team.
However, the microservices architecture—with the core backend, account backend, and additional microservices—remained in place, requiring us to maintain multiple repositories and coordinate changes across them.
This often involved creating pull requests in multiple repositories and coordinating rollouts, which was time-consuming and error-prone.

For us, the major benefit of a modulith is the enhanced maintainability.
With just one development team, we have a single application and repository.
The modulith has greatly simplified our workflows and reduced the overhead of managing multiple repositories.

## Technical Side of Our Modulith

With the new development endeavor, the smaller development team, and using a modular monolith architecture, we chose [Spring Modulith](https://spring.io/projects/spring-modulith) for our new backend.
Spring Modulith provides built-in support for working with events—something we previously handled manually using Kafka, a common message library, and Kafka consumers(see also: [here]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}) and [here]({% post_url 2023-08-04-tales-from-a-startup-and-its-evolving-architecture %}))—and also supports strong module separation through [ArchUnit tests](https://docs.spring.io/spring-modulith/reference/verification.html).
A good tutorial on Spring Modulith is available at [Baeldung.com](https://www.baeldung.com/spring-modulith).

So far, we are happy with our choice.
However, it is also already becoming apparent that we soon will face issues stemming from monolithic architectures such as the sheer amount of dependencies to external systems and libraries.
These are trade-offs we will continue to evaluate as our application evolves.

## Conclusion

The modular monolith, or "modulith," has proven to be a valuable architectural choice for our team at HUK-Autowelt.
By adopting this approach, we have simplified our development processes, improved maintainability, and adapted to the constraints of a smaller development team.
Spring Modulith has provided us with the tools to enforce strong module separation and streamlined event handling which was challenging in our microservices-based architecture before.

However, as with any architectural decision, trade-offs are inevitable.
While the modulith has addressed many of our pain points, we are aware of potential challenges, such as managing dependencies and scaling the application.
These are considerations we will continue to monitor and address as needed.

Ultimately, the decision to move to a modulith was driven by our specific context and constraints.
For teams facing similar challenges, the modulith offers a compelling middle ground between the "simplicity" of monoliths and the modularity of microservices.
We hope our experiences provide valuable insights for others exploring this architectural style.

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autowelt](https://www.huk-autowelt.de) for their outstanding work.