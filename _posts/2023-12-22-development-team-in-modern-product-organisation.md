---
layout: post
date:   2023-12-22 08:10:10 +0100
title: "Development Teams in a Modern Product Organisation"
categories:
  - Strategy
  - Engineering
  - Culture
published: true
hero_image: "/assets/hero-tales_from_startup_and_its_evolving_architecture.svg"
---
In the beginning of this year, I was asked to review a German article about how to build up and organize a modern product organisation.
The article is now available at {% cite Schultheiss2023 %}.
In this article, I would like to tell you a little bit more about the development team's side of such a modern product organisation.
How to establish an engineering culture supporting the modern product organization as well as building a team's mindset about that and so on.

## Introduction

> Disclaimer: This article presents my personal opinions and perspectives on engineering culture, development strategy, software architecture, etc.
> So, this is not necessary my company's opinion.

Maybe you have read [that]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}), [that]({% post_url 2022-10-13-with-four-key-metrics-towards-development-excellence %}), or [that]({% post_url 2023-08-04-tales-from-a-startup-and-its-evolving-architecture %}) article already.
Those articles are about the technical perspective on the evolution process of a start-up.
But what is about the engineering culture perspective?
How does a development team have to support a product team in a start-/scale-up?
What should be the mindset of the team—especially when you co-lead the development team with the product team?

### Modern Product Organizations

A product organization is the structure and processes to ideate, create, develop, deploy, promote, adapt, and—later also—sunset products {% cite Schultheiss2023 %}, {% cite Cagan2008 %}, {% cite Cagan2010 %}, {% cite Venkateswaran2021 %}, and {% cite Birds2023 %}.
For the sake of this article ({% cite Schultheiss2023 %} also does it), we only refer to digital products that are developed end-to-end via IT.

Thereby, product organizations differ from a project organizations so that a product organization is built around the empowered product team (see also: {% cite Cagan2017%} and {%cite Cagan2021 %}) and not around projects.
The teams are cross-functional.
They are set up around customer-focussed products or services that they own end-to-end.
Here, the cross-functional product team consists of product designers (UI and/or UX), product managers/product owners, software developers, DevOps/site reliability engineers, and all other roles necessary to focus on the product development.
{% cite Cagan2019 %}, {% cite Cagan2019a %}, and {% cite Narayan2018 %} summarize the differences between products and projects quite well.

There are further aspects of a modern product organization such as the product operating model or the way of structuring teams which we focus later on.
For me, it is important to emphasize what also Marty Cagan writes about the structural aspects:
"Finally, realize that there is never a perfect way to structure a team – every attempt at structure of the product organization will be optimized for some things at the expense of others. So as with most things in product, it involves trade-offs and prioritization." {% cite Cagan2010 %}.

### Way of Working in Development Teams

TODO