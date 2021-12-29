---
layout: post
date:   2021-12-26 07:40:00 +0100
title: "Interdependencies between Organization and Software Architecture (Part III) - Domain-driven Design"
categories:
  - Architecture
  - Organization
  - Domain-driven Design
published: true
---
As an architect or engineering manager, you are often facing situations where you realize interdependencies between your organization and software architecture.
What team should maintain a specific component within a larger architecture or organization?
How to (re-)structure teams when facing a bigger architecture rework or a new project?
This is part III within a [series of five articles]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-I-overview %}) (see also: [part II]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-II-conway %})) where we discuss different approaches to describe those interdependencies between organization and software architecture.
It is about Domain-driven Design (DDD) an approach invented by Evans in his book "Domain-driven Design" in 2003.

## Introduction

Domain-driven Design (DDD).

## Domain-driven Design

Besides Conway's Law and the Inverse Conway Maneuver, also Domain-driven Design (DDD) can be used to explain the interdependencies between organization and architecture.
Originally developed by Eric Evans in the 2000er years (see also: {% cite Evans2003 %}), DDD is about designing software based on models of the domain.
The domain models, therefore, act as a Ubiquitious Language and as a conceptual foundation for the design of the software {% cite Fowler2014 %}.

When building microservices, a very important thing is to find the right scope for these microservices.
Overlapping or unknown domains as well as unclear interrelationships between teams are often the underlying reasons of problems with microservices.
Here, Domain-driven Design (DDD) is considered to be a "tool" which can help (see also: {% cite Newman2019 %}).

A central pattern in DDD is the Bounded Context.
Bounded Contexts encapsulate a certain set of assumptions, a common Ubiquitous Language, and a particular domain model in a coherent environment.
Via Bounded Contexts, the software can be divided into smaller parts with clear boundaries and interfaces between each other.

DDD, furthermore, tries to define the interfaces between those smaller parts - so, relationships between Bounded Contexts - in a variety of ways {% cite Fowler2014 %} (see also: {% cite Brandolini2009 %}).
Via so-called Context Mapping,

...TODO...

In a nutshell, DDD can help to map interdependencies between organization and software architecture and, thus, to tailor organizations, teams, and software.

## Conclusion

This article is definitely not the first article about the interdependencies of organization and architecture.
In {% cite Wolff2020 %} (it is only available in German), {% cite Ardalis2020 %}, and {% cite Skelton2020 %}, the authors describe the different aspects of interdependencies between an organizational structure and software architecture in terms of the modules and components.

In {% cite Bloomberg2015 %}, Bloomberg summarizes Conway's Law and the Inverse Conway Maneuver in the context of the DevOps movement.

## References

{% bibliography --cited %}
