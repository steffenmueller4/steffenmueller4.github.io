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

Recently, I have read Marianne Bellotti's post about [hunting tech debt via org charts](https://bellmar.medium.com/hunting-tech-debt-via-org-charts-92df0b253145) with delight.
And... yes, I observed similar things in my work experience.
After working as an IT consultant in the public sector, as a research associate in big a research project, and in several product-focussed companies in various roles, I can definitely back Marianne Bellotti's observations that there is common tech debt stemming from different organization setup.

Marianne Bellotti writes about being able to predict several key details of organization's problems by looking at people's titles meeting her for talking about legacy modernization and by looking at the organzation chart of the company.
She, furthermore, explains that "the types of problems organizations have are heavily influenced by their incentive structure and the easiest way to figure out their incentive structure is by looking at the org chart." {%cite Bellotti2021 %}
The incentive structure is driving and shaping the organization, because it drives and shapes what the organization prioritizes in the day to day work and how people in the organization get ahead.
The tech debt is then going to accrue in the day to day work of people in the organization due to their priorities {%cite Bellotti2021 %}.

Similar mechanisms appear when it comes to organization and software architecture.
The organization structure is shaping the architecture in various ways.
When, for example, two teams are architecting a new solution, they will typically come up with at least two independent components.
This seems to be quite natural.
However, when you consider this from an 
As the organization is driven by the incentive structure, this, in turn, also falls back to the architecture.
In the following parts, I will give you different approaches that describe the interdepencies 

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
