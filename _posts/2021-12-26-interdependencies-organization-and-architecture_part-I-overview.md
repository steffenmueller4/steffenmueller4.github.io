---
layout: post
date:   2021-12-26 08:00:00 +0100
title: "Interdependencies between Organization and Software Architecture - Overview"
categories:
  - Architecture
  - Organization
published: true
---
As an architect or engineering manager, you are often facing situations where you realize interdependencies between your organization and software architecture.
What team should maintain a specific component within a larger architecture or organization?
How to (re-)structure teams when facing a bigger architecture rework or a new project?
In this series of five articles, we discuss different approaches to describe those interdependencies between organization and software architecture.
We will have a look at [Conway's Law and the Inverse Conway Maneuver]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-II-conway %}), [Domain-driven Design (DDD)]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-III-domain-driven-design %}), and the [Team Topologies approach]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-IV-team-topologies-approach %}) and how these approaches can be used to explain those interdependencies and help you to better understand or design your organization or software architecture.

## Introduction

Recently, I have read Marianne Bellotti's post about [hunting tech debt via org charts](https://bellmar.medium.com/hunting-tech-debt-via-org-charts-92df0b253145).
And... unfortunately, I have to say: yes, I observed similar things, too.
From my work experience in consulting, in the public sector, and in several product-focussed companies, I have to back her in her observations that there is common tech debt stemming from different organization setup.
The organization setup drives and shapes the incentive structure and, therefore, the entire technical setup such as the communication structure of teams as well as the architecture based on the day to day work in the organzation.
It simply drives what the organization is prioritizing.

In this series of five articles, I will try to explain you why I think that Marianne Bellotti is right that there is typical tech debt arising from the different organization structures.
I will try to give you examples from my work experience.
Additionally, I will try to describe the backgrounds why there are strong interdependencies between organization and architecture and, thus, piling up different problems.

But first let's look at Marianne Bellotti's post in more detail.
In her post, Marianne Bellotti writes about blowing "[...] peoples’ minds with a fairly simple party trick." {%cite Bellotti2021 %}
She writes about being able to predict several key details of organization's problems only by looking at people's titles meeting her for talking about legacy modernization and by looking at the organzation chart of a the company.
The core reason is that "the types of problems organizations have are heavily influenced by their incentive structure and the easiest way to figure out their incentive structure is by looking at the org chart." {%cite Bellotti2021 %}
The incentive structure is driving and shaping the organization, because it drives and shapes what the organization prioritizes in the day to day work and how people in the organization get ahead.
In the day to day work, then the tech debt is going to accrue {%cite Bellotti2021 %}.



## Examples from my Work Experience

As an architect, I was involved in a strategical project where two teams should develop a brand new solution to model terraces, fences, etc. in the garden.
From that model of the terrace, fences, etc., the application ought to derive the construction plan and the bill of material, so the terraces, fences, etc. could be constructed.
The two teams that should develop the solution, were a product team being responsible to build the customer-facing application and a support team maintaining master data required as input for the purposes of the new solution.

Unfortunately, both teams - including me ;-) - had different ideas of the overall software architecture.
There were different architecture proposals leading to different degrees of dependencies between those two teams.
One architecture proposal was about to intertwine both teams in a way that both teams would have to be merged as otherwise major inefficiencies would arise.
Another architecture proposal considered both teams to stay independent but required to change the overall process of master data management.
What architecture should we choose?

Another example stems from my time as an engineering manager.
I was building up a new organizational unit which should build a new application.

TODO:
[Conway's Law]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-II-conway %})
[Domain-driven Design]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-III-domain-driven-design %})
[Team Topologies approach]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-IV-team-topologies-approach %})

## References

{% bibliography --cited %}
