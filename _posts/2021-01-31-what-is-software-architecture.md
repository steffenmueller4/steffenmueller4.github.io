---
layout: post
date:   2021-01-31 10:11:08 +0100
title: "Software Architecture in a very Agile Environment"
categories:
  - Architecture
  - Domain-driven Design
published: false
---
In recent months, my team and me are rebuilding parts of a ca. 8 year-old monolithic three-tier PHP application using a microservice-based architecture. Goal is to get a better maintainable architecture fitting the very agile environment we are confronted with. Before we started and even during our ongoing efforts, I often thought and still thinking about our desired software architecture, the important characteristics we need to achieve, and about how can we come up with a good software architecture for our purposes. In this post, I would like to describe my experience so far and describe a little bit our reasoning.

At trivago, we are very proud of our agile and value-driven environment. Although, this environment also has its downsides, we were able to overcome a lot of challenges in recent times. One aspect of this environment is that trivago there are often drastical technical and organizational changes. Moreover, trivago does not have a central software architecture responsibility dealing with enterprise, solution, or even software architecture aspects. On one hand, all this leads to very independent teams being able to move really fast. Every team is fully in charge of building solution to drive their business. On the other hand, this also brings a lot of challenges for the tech leads like me and their teams. These challenges become even bigger, when you have to renew the application while reducing the number of developers working in the team drastically at the same time.

When I was joining the team as their tech lead in summer 2020, I was confronted with a ca. 8 year-old monolithic three-tier PHP application. In the application, a lot of software architects

[//]: # (#)
[//]: # (References)
[//]: # (#)

[tilkov-good-enough-architecture]: https://www.youtube.com/watch?v=PzEox3szeRc
