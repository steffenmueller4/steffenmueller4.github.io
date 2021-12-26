---
layout: post
date:   2021-12-26 07:30:00 +0100
title: "Interdependencies between Organization and Software Architecture (Part IV) - Team Topologies Approach"
categories:
  - Architecture
  - Organization
  - Team Topologies Approach
published: true
---
As an architect or engineering manager, you are often facing situations where you realize interdependencies between your organization and software architecture.
What team should maintain a specific component within a larger architecture or organization?
How to (re-)structure teams when facing a bigger architecture rework or a new project?
This is part IV within a series of five articles where we discuss different approaches to describe those interdependencies between organization and software architecture.
It is about the Team Topologies approach initially described by Skelton and Pais in their book "Team Topologies" in 2019.

## Introduction

Team Topologies Approach.

## Team Topology Approach

In 2019, Skelton and Pais described another approach focusing on the interdependencies between the organization and software architecture {% cite Skelton2019 %}: the Team Topology approach (see also: Skelton's and Pais' talk at the DevOps Enterprise Summit 2019 at {% cite Skelton2019b %} and the corresponding blog entry at {% cite Skelton2019a %}).
The Team Topology approach focuses on the team and the "team's cognitive load" before tailoring and defining the organization, application boundaries, and architectures from a technical perspective or domain perspective.
Thus, it is a socio-technical approach to building software systems (see also: {% cite Lane2020 %}).

Thereby, the team's cognitive load means "[...] the total amount of mental effort being used in the working memory" {% cite Skelton2019a %}.
For cognitive load, we can distinguish between intrinsic, extraneous, and germane cognitive load.
In a software engineering context, intrinsic can be understood as skills that a team member needs to have.
It "[...] comes naturally and becomes an intrinsic part of how we work." {% cite Skelton2019a %}
Extraneous, however, is something working against what we are doing that is effectively valueless.
You can consider it as the "[...] mechanisms of how we do things in a software world." {% cite Skelton2019a %}
For example, specific quirks of how to deploy an application in the organization's Kubernetes cluster or how to pass a specific system property to the application.
Last but not least, germane is the cognitive load which stems from the business problem that we are trying to solve.
It can be considered as the domain focus in software engineering {% cite Skelton2019a %}.

...TODO: Goal of team's cognitive load setup: Limit the size of software services/products to the cognitive load that the team can handle

They consider basics and principles stemming from newer experiences and knowledge of the DevOps movement and modern software engineering management approaches.
Examples:
  * Maximum team size should follow the principle of the two-pizza-team, so 9 to max. 12-15 people (see also: a summary of the science behind that rule can be found, for example, at {% cite Choi2018 %}).
  * The teams should be fully responsible for the software artifact/product. Thus, the software/product should have a proper developer and operator experience that the team supports. From a DevOps perspective, it should follow the "you build it, you run it"-approach. From the product perspective, you can consider the approach as the fully empowered product teams (see also: {% cite Cagan2017 %})
  * The teams should be cross-functional 
  * Well-chosen domain boundaries (see: DDD)

Thereby, the teams should be split up into stream-aligned product, platform, enabling, and complicated subsystem teams.
"The team that is aligned to part of the value stream for the business and they have end-to-end responsibility for building, deploying, running, supporting, and eventually retiring that slice of the business domain or that slice of service. The other types of teams listed below are effectively there to reduce the cognitive load of the Stream-aligned team." {% cite Skelton2019a %}

...TODO: 3 interaction modes of teams

## Summary

This article is definitely not the first article about the interdependencies of organization and architecture.
In {% cite Wolff2020 %} (it is only available in German), {% cite Ardalis2020 %}, and {% cite Skelton2020 %}, the authors describe the different aspects of interdependencies between an organizational structure and software architecture in terms of the modules and components.

In {% cite Bloomberg2015 %}, Bloomberg summarizes Conway's Law and the Inverse Conway Maneuver in the context of the DevOps movement.

## References

{% bibliography --cited %}
