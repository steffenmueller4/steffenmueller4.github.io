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
hero_image: "/assets/hero-four_key_metrics.svg"
---
Recently, I have been giving [a talk to students at TU Berlin about Cloud-native engineering and software architecture](https://www.linkedin.com/posts/steffen-mueller-139b8b191_tuberlin-activity-7080612706663182336-aCQo) as a part of [Prof. Tai](https://www.tu.berlin/ise/ueber-uns/prof-dr-ing-stefan-tai)'s lecture [Cloud Native Engineering and Architecture](https://www.tu.berlin/ise/studium-lehre).
I explained to the students the approach to software architecture and engineering that my team and me are running.
From a 10,000 feet perspective, we are running an [event-driven microservices architecture]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}) in an agile way to build a customer-first product based on a [Cloud Platform](https://tag-app-delivery.cncf.io/whitepapers/platforms/) that the DevOps/Site Reliability Engineering team is developing and maintaining.
This article summarizes the talk and provides further insights into come core concepts we are pursuing.

## Introduction

> Disclaimer: This article presents my personal opinions and perspectives on a Cloud-native development strategy and software architecture, so this is not necessary my company's opinion.

In a couple of articles (see, e.g.: [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %})), I have already explained that I am currently working at a corporate start-up.
The company builds a platform for booking car services online ([HUK-Autoserivce](https://www.huk-autoservice.de)) based on modern product and development concepts such as agile development processes, a bias to fast and experiment-driven development (see also: [this article about our deployment concepts]({% post_url 2022-10-13-with-four-key-metrics-towards-development-excellence %})), and a Cloud-native platform.

Like my current employer, all start-ups typically have the challenge that they still need to find their [product-market fit](https://en.wikipedia.org/wiki/Product/market_fit).
So, start-ups should rather concentrate on solving business problems than on solving technology challenges such as preparing the architecture to scale later on.
Thus, you should focus on using rock-solid technology to build a prototype as fast and as cheaply as possible to prove the business model—best guess is a modular monolith.
When the business model evolves, the journey continues and you have to scale the business model, but not obviously in the technical sense of having to handle millions of requests per second.
You have to stay ahead of the business and to scale the organization which means you typically increase the number of teams participated in the product's development.
For that, it may be a good idea to make use of microservices to make teams independent from each other.
Randy Shoup structures this journey of start-ups during their evolution nicely based on the business growth s-curve (see also: {% cite Boretos2012 %}) in a very good talk about [minimum viable architecture](https://www.youtube.com/watch?v=9Q7GANXn02k) (MVA).
He summarizes this journey into the meaningful start of his talk with: "There is no perfect architecture for all scales, for all phases of evolution, [and] for all problem domains." {% cite Shoup2022 %}

My employer has rather started—and is now for sure—in the scaling phase.
We just adapted the business model slightly in 2021 when I joined and the development restarted which I described first in [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}).
Essentially, we built an event-driven microservices architecture (EDA) and are still continuing this approach.
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

Based on the MVA approach, we, thus, focussed on the two following objectives when building our application:

 1. We want to create an awesome customer-centric product (see also: MVP), and
 1. we want to build a scalable, flexible, secure, and reliable microservices-oriented architecture for a fast and experiment-driven business development (... based on the MVA approach).

Essentially, we want to gain—what Gregor Hohpe in {% cite hohpe2020 %} describes as—"[economies of speed](https://www.oreilly.com/library/view/the-software-architect/9781492077534/ch35.html)" with our product via the MVA approach.

## How does an Event-driven Architecture fit into that?

You could argue that an EDA that was already mentioned in [this section](#introduction) does not fit into the MVA approach.


## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autoservice](https://www.huk-autoservice.de) for the awesome work.