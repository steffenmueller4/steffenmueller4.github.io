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
I explained to the students the approach to software architecture and engineering that my team and me are running.
From a 10,000 feet perspective, we are running an [Event-Driven Microservices Architecture]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}) to build a customer-first product based on a [Cloud Platform](https://tag-app-delivery.cncf.io/whitepapers/platforms/) that the platform team is developing and maintaining.
This article summarizes the talk and provides further insights into some core concepts we use.

## Introduction

> Disclaimer: This article presents my personal opinions and perspectives on a Cloud-native development strategy and software architecture, so this is not necessary my company's opinion.

In a couple of articles (see, e.g.: [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %})), I have already explained that I am currently working at a corporate start-up.
The company builds a platform for booking car services online ([HUK-Autoserivce](https://www.huk-autoservice.de)) based on modern product and development concepts such as agile product development processes, a bias to fast and experiment-driven development (see also: [this article about our deployment concepts]({% post_url 2022-10-13-with-four-key-metrics-towards-development-excellence %})), and a Cloud-native platform.

Similar to my current employer, all start-ups typically have the challenge that they often still need to find their [product-market fit](https://en.wikipedia.org/wiki/Product/market_fit).
So, start-ups should rather concentrate on solving business problems than on solving technology challenges such as preparing the architecture to scale later on.
Thus, you should focus on using rock-solid technology to build a prototype as fast and as cheaply as possible to prove the business model—best guess is a modular monolith.
When the business model evolves, the journey continues and you have to scale the business model, but not obviously in the technical sense of having to handle millions of requests per second.
You have to stay ahead of the business and to scale the organization which means you typically increase the number of teams participated in the product's development.
For that, it may be a good idea to make use of microservices to make teams independent from each other.
Randy Shoup structures this journey of start-ups during their evolution nicely based on the business growth s-curve (see also: {% cite Boretos2012 %}) in a very good talk about [Minimum Viable Architecture](https://www.youtube.com/watch?v=9Q7GANXn02k) (MVA).
He summarizes this journey into the meaningful start of his talk with: "There is no perfect architecture for all scales, for all phases of evolution, [and] for all problem domains." {% cite Shoup2022 %}

My employer has rather started—and is now for sure—in the scaling phase.
We just adapted the business model slightly in 2021 when I joined and the development restarted which I described first in [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}).
Essentially, we built an Event-Driven Architecture (EDA) based on microservices and are still continuing this approach.
Nevertheless, we follow clearly the idea of MVA.
So, let us dive deeper into the concept of MVA and our approach to it in the [next section](#minimum-viable-architecture-and-our-approach-to-it).

## Minimum Viable Architecture and our Approach to it

Software architects and engineers often have to decide how much architectural design they should do in the beginning of a project or product.
The concept of MVA tells you to focus on the essential architecture needed to deliver a minimum viable product (MVP).
An MVP is a version of a product—in our case a digital product respectively an application—with just enough features to be delivered to early customers for providing feedback for further product development {% cite WikipediaMinimumViableProduct2023 %}.
When following the concept of MVA, you, thereby, delay design decisions until they are absolutely necessary to avoid lengthy and unnecessary work as well as architect for change {% cite Pureur2021 %}.
The most memorable explanation of MVA is that you concentrate on delivering "just enough architecture" for releasing an MVP {% cite Caroli2015 %}, {% cite Karanth2016 %}, {% cite Pureur2021 %}, {% cite Erder2021 %}, {% cite Bittner2022 %}, or {% cite Shoup2022 %}.

As already explained via Randy Shoup's talk about MVA in the [previous section](#introduction), there is no perfect architecture that fits all scales, alls phases, and all problem domains.
Thus, the MVA approach is, in my believe, the most essential lesson to learn for engineers—especially when you are in a start-up.
Just do enough architecture.
This, however, may also mean that you have to increase your efforts about architecture when you proceed in your journey.

Based on the MVA approach, we, thus, focussed on the two following objectives when building our application(s):

 1. We want to create an awesome customer-centric product (see also: MVP and TODO product org), and
 1. we want to build a scalable, flexible, secure, and reliable microservices-oriented architecture for a fast and experiment-driven business development (... based on the MVA approach).

Essentially, we want to gain—what Gregor Hohpe in {% cite Hohpe2020 %} describes as—"[economies of speed](https://www.oreilly.com/library/view/the-software-architect/9781492077534/ch35.html)" with our product via the MVP and MVA approach.
The MVP and MVA concepts help us to stay flexible and, thus, also be fast.

## How does an Event-Driven Architecture fit into that?

In order to gain the economies of speed (see: [this section](#minimum-viable-architecture-and-our-approach-to-it)), we decided to go, as already mentioned in [this section](#introduction), with an EDA from a 10,000 feet perspective.
An EDA, in general, has the following benefits to us (see also: [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}) as well as {% cite Hohpe2003 %} and {% cite Jansen2020 %}):

 1. Loose Coupling: Event producers and consumers in an EDA are coupled loosely and communicate asynchronously via an event broker (data format coupling only).
 1. Partial Resiliency: The event broker separates event producers and consumers from each other and, thus, introduces partial resiliency to system parts.
 1. Partial Scalability: Due to loosely coupled and separated producer and consumer components, we can scale our producers and consumers independently.
 1. Single Source of Truth: Our event broker is the single source of truth which keeps domain/business events and allows us to rewrite, combine, extract, rework, ... the events to feed other systems and purposes.

You could argue that an EDA does not fit into the MVA approach, because it is a complex architecture that speaks against the MVA approach.
We use the EDA to structure our overall system rather from a solution or enterprise architecture perspective (10,000 feet perspective, see also: [Levels of Architecture](https://github.com/justinamiller/SoftwareArchitect#levels-of-architecture)) via events.
We use Domain-Driven design (DDD) {% cite Evans2003 %} to identify and structure the events.
The business/domain events are, thus, records of business-significant occurrences in a bounded context used to react to in other bounded contexts.
You can also think about those events as integration points for other bounded contexts.
We extend our microservices continously with new such business events as soon as we need them.
On an application architecture level, we rather have independently deployable microservices or maybe even modular monoliths per team.
So far, this approach went well and kept us flexible and fast—of course there are also challenges to maintain the architecture.
For more details about the EDA approach, we also refer to [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}).

## A Cloud-native Platform as a Basis for the Development

According to the Team Topologies approach {% cite Skelton2019 %}, {% cite Skelton2019a %}, and {% cite Skelton2019b %}, we try to structure our development teams into stream-aligned product and platform teams.
The platform team develops and maintains the development platform to build business applications upon it.
It reduces the complexity for the stream-aligned product teams, so the stream-aligned product teams can focus on dealing with the business complexity (... and, in our case, with the EDA) as well as the product development processes.
The stream-aligned product teams, as part of the business value stream, have end-to-end responsibility for building, deploying, running, supporting, and eventually sunsetting their part of the business or that slice of service.
They consist of developers and parts of the product team, especially Product Owners.
Consequently, the cross-functional stream-aligned product teams can fully concentrate on processes to design, test (product discovery), develop, as well as ship and evolve (product delivery) the products (see also: {% cite Schultheiss2023 %}).

The Cloud-native platform, thereby, is providing foundational capabilities, basic frameworks, and "experiences" as well as some best practices to facilitate and accelerate the product development of the stream-aligned teams {% cite CNCF2023 %}.
Essentially, the platform is an intermediate layer between our Cloud provider(s) and the internal customers such as the stream-aligned teams.
It is run as a product by the platform team.
The figure below depicts our current platform and the provided services.
The basic structure of the platform in the figure is based on the Cloud Native Computing Foundation's (CNCF) definition of a platform and platform engineering in {% cite CNCF2023 %}.

![Our Cloud-native Development Platform](/assets/our-development-platform.png)

Our Cloud provider is Amazon Web Services (AWS) which is shown at the bottom of the figure.
Using the basic AWS services, the platform provides its platform capabilities via Kubernetes as our container runtime ([Amazon Elastic Kubernetes Service](https://aws.amazon.com/eks/)), diverse databases (via [Amazon Relational Database Service](https://aws.amazon.com/rds/)), the event broker for the EDA ([Apache Kafka](https://kafka.apache.org) via [Amazon Managed Streaming for Apache Kafka](https://aws.amazon.com/msk/)), etc.
For the platform interfaces, we use a bug tracker ([Atlassian Jira](https://www.atlassian.com/software/jira)), a wiki for documentation ([Atlassian Confluence](https://www.atlassian.com/software/confluence)), specific [Github](https://www.github.com) repositories as basic project templates, etc.
For more information on our Continous Integration and Delivery (CI/CD) using [Github](https://www.github.com) and [Github Actions](https://github.com/features/actions), we refer to [this article]({% post_url 2022-10-13-with-four-key-metrics-towards-development-excellence %}).

So far, this thin platform—remember the MVP and MVA concepts ;-)—works well for the stream-aligned product teams to build our applications.
The platform is, as the other products, under continous development by the platform team.
For example, we are currently exchanging the monitoring, logging, and tracing stack to ease the work of the DevOps/Site Reliability Engineers.

## Conclusion

Although we as software architects and engineers as well as product owners, etc. are often tempted to extend our products and services massively, the MVP and MVA approaches help us to concentrate on the necessary things.
Especially in the context of a start-up, those concepts are essential for building products and a Cloud-native platform.

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autoservice](https://www.huk-autoservice.de) for the awesome work.