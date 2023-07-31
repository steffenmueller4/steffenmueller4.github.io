---
layout: post
date:   2023-07-22 17:21:23 +0100
title: "Tales from a Start-Up Company and its Evolving Architecture"
categories:
  - Strategy
  - Architecture
  - Event-Driven Architecture
  - Cloud Platform
published: true
hero_image: "/assets/hero-tales_from_startup_and_its_evolving_architecture.svg"
---
Recently, I have been giving [a talk to students at TU Berlin about Cloud-native engineering and software architecture](https://www.linkedin.com/posts/steffen-mueller-139b8b191_tuberlin-activity-7080612706663182336-aCQo) as a part of [Prof. Tai](https://www.tu.berlin/ise/ueber-uns/prof-dr-ing-stefan-tai)'s lecture, [Cloud Native Engineering and Architecture](https://www.tu.berlin/ise/studium-lehre).
I explained to the students the approach to software architecture and engineering that my team and me are following.
From a 10,000 feet perspective, we are developing an [Event-Driven Microservices Architecture]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}) to build a customer-first product based on a [Cloud-native platform](https://tag-app-delivery.cncf.io/whitepapers/platforms/).
But there is much more in the background such as the concepts of Minimum Viable Product, Minimum Viable Architecture, etc.
This article summarizes the talk, connects topics to some of my previous articles, and provides further insights into some core concepts we use.

## Introduction

> Disclaimer: This article presents my personal opinions and perspectives on a Cloud-native development strategy, software architecture, and engineering.
> So, this is not necessary my company's opinion.

In a couple of articles (see, e.g.: [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %})), I have already explained that I am currently working at a corporate start-up.
The company started in 2021 to build an application for booking car services online based on a modern product and development approach such as agile development processes and a Cloud-native platform ([HUK-Autoserivce](https://www.huk-autoservice.de), see also: [this article about our deployment concepts]({% post_url 2022-10-13-with-four-key-metrics-towards-development-excellence %})).
Although we have started in 2021, our journey is still not finished as our vision is bigger.

Thereby, my company and its challenges are by far not special.
Similar to my company, all start-ups typically have their challenges during the evolution and during different phases of their journey.
When a start-up is, for example, in the initial phase of proving its business model, we should focus on using rock-solid technology to build a prototype as fast and as cheaply as possible to prove the business model.
When the start-up and the business model evolves, the journey continues and we have to scale the business model, but not obviously in the sense of having to handle millions of requests per second but maybe only in the number of teams building the product.
Always, there is the challenge to stay technically ahead of the business and to stay flexible with your organization.
Randy Shoup structures this journey of start-ups and their challenges during their evolution nicely based on the business growth s-curve (see also: {% cite Boretos2012 %}) [in a very good talk](https://www.youtube.com/watch?v=9Q7GANXn02k) {% cite Shoup2022 %}.
It all boils down to the meaningful start of his talk: "There is no perfect architecture for all scales, for all phases of evolution, [and] for all problem domains." {% cite Shoup2022 %}

In 2021, my employer has rather started—and is now for sure—in the scaling phase, because the business model has been proven by the parent company earlier.
We just adapted the business model slightly in 2021 when I joined and the development of the product has been restarted (see also: [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}).
Back then, we have started to build an Event-Driven Architecture (EDA) based on microservices and are still continuing this approach.
Nevertheless, we clearly follow the idea of Minimum Viable Architecture (MVA).
So, let us dive deeper into the concept of MVA and our approach to it in the [next section](#minimum-viable-architecture-and-our-approach-to-it).

## Minimum Viable Architecture and our Approach to it

Software architects and engineers often have to decide how much architectural design they do in the beginning of a project or product.
All in all, the concept of MVA tells you to focus only on the essential architecture needed to deliver the Minimum Viable Product (MVP).
An MVP is a version of a product with just enough features to be delivered to early customers for providing feedback as early as possible for further product development {% cite WikipediaMinimumViableProduct2023 %}.
When following the concept of MVP and MVA, you should delay design decisions until they are absolutely necessary to avoid lengthy and unnecessary work.
On top, it is better to architect for change {% cite Pureur2021 %}.
The most memorable explanation of MVA is that you concentrate on delivering "just enough architecture" for releasing an MVP {% cite Caroli2015 %}, {% cite Karanth2016 %}, {% cite Pureur2021 %}, {% cite Erder2021 %}, {% cite Bittner2022 %}, or {% cite Shoup2022 %}.

As already explained via the start of Randy Shoup's talk {% cite Shoup2022 %} in the [previous section](#introduction), there is no perfect architecture that fits all scales, alls phases, and all problem domains.
Thus, the MVA approach is, in my believe, the most essential lesson to learn for engineers—especially when you are in a start-up: Just do enough architecture and build for change; do not overengineer your solution.
So far, the MVA approach has helped us to stay focussed, flexible, and, thus, also fast.

## How does an Event-Driven Architecture fit into that?

As already mentioned in [this section](#introduction), we decided to go with an EDA from a 10,000 feet perspective.
We use Domain-Driven Design (DDD) {% cite Evans2003 %} to identify and structure the business/domain events for the EDA.
Consider the business/domain events as records of business-significant occurrences in a bounded context—when you are not familiar with the term bounded context, simply use the term microservice instead.
An EDA, in general, has the following benefits {% cite Hohpe2003 %} and {% cite Jansen2020 %} (see also: [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %})):

 1. Loose Coupling: Event producers and consumers in an EDA are coupled loosely and communicate asynchronously via an event broker (data format coupling only).
 1. Partial Resiliency: The event broker separates event producers and consumers from each other and, thus, introduces partial resiliency to system parts.
 1. Partial Scalability: Due to loosely coupled and separated producer and consumer components, we can scale our producers and consumers independently.
 1. Single Source of Truth: Our event broker is the single source of truth which keeps domain/business events and allows us to rewrite, combine, extract, rework, ... the events to feed other systems and purposes.

Now, you could argue that an EDA does not fit into the MVA approach, because it is rather a complex architecture.
However, we use the EDA to structure our overall system rather from _10,000 feet perspective_, so rather from the solution or enterprise architecture perspective (see also: [Levels of Architecture](https://github.com/justinamiller/SoftwareArchitect#levels-of-architecture)).
On an application architecture level, we use much simpler architecture approaches that the different teams can select and drive.
Here, we rather focus on independently deployable microservices or maybe even modular monoliths per team.
In essence, you can think of the EDA as our integration mechanism for other systems and purposes.
When needed, we extend our microservices with new such business events.
Furthermore, we are able to completely restructure or rebuild the different underlying microservices as long as we do not change the business/domain events.

So far, this way to work with the MVA approach and the EDA went well and kept us focussed, flexible, and fast—of course there are also challenges to maintain the EDA architecture, but no architecture is free of any challenges.
For more details about the EDA approach, we also refer to [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}).

## A Cloud-native Platform as a Basis for the Development

According to the Team Topologies approach {% cite Skelton2019 %}, {% cite Skelton2019a %}, and {% cite Skelton2019b %}, we try to structure our development teams into stream-aligned product and platform teams.
The platform team develops and maintains the [Cloud-native platform](https://tag-app-delivery.cncf.io/whitepapers/platforms/) to build business applications upon it.
It reduces the complexity for the stream-aligned product teams, so the stream-aligned product teams can focus on dealing with the business complexity (... and, in our case, with the [EDA](#how-does-an-event-driven-architecture-fit-into-that)) as well as the product development processes.
The stream-aligned product teams, as part of the business value stream, have end-to-end responsibility for building, deploying, running, supporting, and eventually sunsetting their part of the business or that slice of service.
They are cross-functional and consist of front- and back-end developers as well as Product Owners.
Consequently, the stream-aligned product teams can fully concentrate on processes to design, test (product discovery), develop, as well as ship and evolve (product delivery) the products (see also: {% cite Schultheiss2023 %}).

The Cloud-native platform, maintained and developed by the platform team as a product, is providing foundational capabilities, basic frameworks, and "experiences"/best practices to facilitate and accelerate the product development of the stream-aligned teams {% cite CNCF2023 %}.
All in all, you can consider the platform as an intermediate layer between our Cloud provider(s) and the internal customers such as the stream-aligned product teams.
The figure below depicts our current platform.
The basic structure of the platform in the figure is based on the Cloud Native Computing Foundation's (CNCF) definition of a platform and platform engineering in {% cite CNCF2023 %}.

![Our Cloud-native Development Platform](/assets/our-development-platform.svg)

Our basic Cloud providers are [Amazon Web Services (AWS)](https://aws.amazon.com), [GitHub](https://www.github.com), [Atlassian](https://www.atlassian.com), and some further providers for smaller services that are not shown in this figure.
This foundational basis is visible at the bottom of the figure.

Using the foundational basis, our platform provides its platform capabilities to be able to provision resources, to provide authentication and authorization services, to deliver Continous Integration and Delivery (CI/CD) pipelines, etc.
The platform capabilities to provision resources are provided via [Kubernetes](https://kubernetes.io/) as our container runtime ([Amazon Elastic Kubernetes Service](https://aws.amazon.com/eks/)) as well as [Helm](https://helm.sh).
We are able to provision diverse databases for managing data via [Amazon Relational Database Service](https://aws.amazon.com/rds/).
For the EDA, we support our event broker, [Apache Kafka](https://kafka.apache.org), via [Amazon Managed Streaming for Apache Kafka](https://aws.amazon.com/msk/).
Last but not least, [Keycloak](https://www.keycloak.org/) is used to provide authentication and authorization services.

For the platform interfaces, we provide documentation capabilities via the bug tracker, [Atlassian Jira](https://www.atlassian.com/software/jira), and a wiki for documentation ([Atlassian Confluence](https://www.atlassian.com/software/confluence)).
Technical documentation is done in readmes in GitHub repositories.
Additionally, we have basic environment and project templates in GitHub repositories as well as [Terraform](https://www.terraform.io) and Helm templates, etc.
Our CI/CD bases on GitHub and [GitHub Actions](https://github.com/features/actions) (for more information on our CI/CD, we refer to [this article]({% post_url 2022-10-13-with-four-key-metrics-towards-development-excellence %})).
Logging, monitoring, and tracing are delivered via Kibana, Grafana, etc.

For us, this thin platform—remember the MVP and MVA concepts ;-)—works well for the stream-aligned product teams to build our applications.
As a product, the platform is under continous development and improvement done by the platform team.
For example, we are currently exchanging the monitoring, logging, and tracing stack to ease the work of the DevOps/Site Reliability Engineers.
With the best practices "baked into" our platform as well as setup of environments and projects, we are able to come up with new containers/microservices in a couple of minutes.

## Conclusion

Sometimes we, as engineers, software architects, etc., tend to extend needlessly or even overengineer our products and services.
The MVP and MVA approaches can help us to concentrate on delivering the necessary things.
Especially in the context of a start-up, those concepts are essential, as there are always developments you cannot forsee and should not pre-consider.
For me and my team at a corporate start-up, the MVP and MVA concepts definitely help to stay focussed, flexible, and fast.



## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autoservice](https://www.huk-autoservice.de) for the awesome work.