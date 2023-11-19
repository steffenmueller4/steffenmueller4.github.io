---
layout: post
date: 2023-11-19 11:30:49 +0100
title: "What is Software Architecture and how to learn about it?"
categories:
  - Architecture
published: true
hero_image: "/assets/hero-four_key_metrics.svg"
---
I strongly believe that understanding of and being able to talk about software architecture is one of the most important skills of software developers and engineers in modern software development.
So, I started this article to write about my understanding.
While doing so, I, however, realized that there are so many good articles, books, videos, etc. that I should not come up with another article with an own definition.
I should rather gather all the articles, books, videos, links, repositories, etc. and put them into the different perspectives.
That is what this article is about: a collection of articles, books, videos, etc. about software architecture to learn what it is and getting a good understanding.

## History and Schools of Software Architecture Definitions

 * Lines and boxes (Bass, Clements)
 * IEEE definition of software architecture (20)
 * Ralph Johnson's and Martin Fowler's interpretation of software architecture (2003): https://martinfowler.com/ieeeSoftware/whoNeedsArchitect.pdf, https://martinfowler.com/architecture/ {% cite Fowler2019 %}
 * [Martin Fowler's keynote at OSCon 2015 about the "what", the "why", and the "how" of software architecture](https://www.youtube.com/watch?v=DngAZyWMGR0)
 * Ford, Parsons, Kua: "Building Evolutionary Architectures - Support Constant Change", 2017 as well as the idea of Minimum Viable Architecture: {% cite Caroli2015 %}, {% cite Karanth2016 %}, {% cite Pureur2021 %}, {% cite Erder2021 %}, {% cite Bittner2022 %}, or {% cite Shoup2022 %}
 * Richards and Ford: "Fundamentals of software architecture", 2020 {% cite Richards2020 %} and {% cite Ford2021 %}

## Levels of Architecture

 * [Justin Miller's GitHub collection about "What is a Software Architect?"](https://github.com/justinamiller/SoftwareArchitect) {% cite Miller2021 %}
 * Those levels differ most in the language:
    * Enterprise Architects speak about capabilities (Archimate, ...) (see: https://en.wikipedia.org/wiki/Enterprise_architecture -> Criticism about EA)
    * Solution Architects make use of services and building blocks to compose a solution to a (business) problem; often Solution Architects are coming from external partners such as AWS, Google, ...
    * At Application Level, we are talking about Modules, Cohesion, Coupling, Desing, Code Quality, etc.
 * InfoQ distinguishes only between Architecture and Enterprise Architecture: https://www.infoq.com/enterprise-architecture/articles/ and https://www.infoq.com/architecture/articles/
 * Nice article: https://www.leanix.net/en/wiki/ea/enterprise-architect-vs-solution-architect-vs-technical-architect-whats-the-difference

## Why is Software Architecture Important?

 * https://martinfowler.com/articles/is-quality-worth-cost.html
 * Hard to change -> see Ralph Johnson's perspective
 * 

## References

{% bibliography --cited %}