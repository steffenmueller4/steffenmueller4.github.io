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
From a 10,000 feet perspective, we are running an [Event-driven Architecture]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}) in an agile way to build a customer-first product based on a [Cloud Platform](https://tag-app-delivery.cncf.io/whitepapers/platforms/) that the DevOps/Site Reliability Engineering team is developing and maintaining.
This post summarizes the talk and provides further insights into come core concepts we are pursuing.

## Introduction

> Disclaimer: This article presents my personal opinions and perspectives on a Cloud-native development strategy and software architecture, so this is not necessary my company's opinion.

In a couple of articles (see, e.g.: [here]({% post_url 2022-05-10-building-an-event-driven-microservice-application %})), I have already explained that I am currently working at a corporate start-up.
The company builds a platform for booking car services online ([HUK-Autoserivce](https://www.huk-autoservice.de)) based on modern product and development concepts such as agile development processes, a bias to fast and experiment-driven development (see also: [this article about our deployment concepts]({% post_url 2022-10-13-with-four-key-metrics-towards-development-excellence %})), and a Cloud-native platform.

Like my current employer, all start-ups typically have the challenge that they still need to find their [product-market fit](https://en.wikipedia.org/wiki/Product/market_fit).
So, start-ups should rather concentrate on solving business problems than on solving technology challenges such as preparing the architecture to scale later on.
Thus, you should focus on using rock-solid technology to build a prototype as fast and as cheaply as possible to prove the business model.
When the business model evolves, the journey continues and you have to scale the business model, but not obviously in the technical sense of having to handle millions of requests per second.
Sometimes you have to scale the number of teams participated in the product's development, because it is a complex product.
Sometimes you have to scale the 
Randy Shoup structures this journey of start-ups nicely based on the business growth s-curve (see also: {% cite Boretos2012 %}) in a very good talk about [Minimum Viable Architecture](https://www.youtube.com/watch?v=9Q7GANXn02k) {% cite Shoup2022 %}.
He summarizes this journey into the meaningful sentence: "There is no perfect architecture for all scales, for all phases of evolution, [and] for all problem domains." {% cite Shoup2022 %}

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autoservice](https://www.huk-autoservice.de) for the awesome work.