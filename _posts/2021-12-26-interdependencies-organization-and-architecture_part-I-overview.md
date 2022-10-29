---
layout: post
date:   2021-12-26 08:00:00 +0100
title: "Interdependencies between Organization and Software Architecture - Overview"
categories:
  - Architecture
  - Organization
published: true
---
As a software architect or engineering manager, you are often facing situations where you realize interdependencies between your organization and software architecture: What team should maintain a specific component within the overall system's architecture?
How do we best (re-)structure teams when facing a reorganization, architecture rework, or a new project?
In this series of five articles, we discuss different approaches to describe those interdependencies between organization and software architecture.
We will have a look at [Conway's Law and the Inverse Conway Maneuver]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-II-conway %}), [Domain-driven Design (DDD)]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-III-domain-driven-design %}), and the [Team Topologies approach]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-IV-team-topologies-approach %}).
Finally, we look at how these approaches can be used to explain those interdependencies and help you to better understand or design your organization and software architecture.

## Introduction

Some time ago, I have read Marianne Bellotti's post about [hunting tech debt via org charts](https://bellmar.medium.com/hunting-tech-debt-via-org-charts-92df0b253145) with delight.
And... yes, I observed similar things in my work experience.
After working as an IT consultant in the public sector, as a research associate in a publicly founded research project, and in several product-focussed companies in various roles, I can definitely back Marianne Bellotti's observations that there is common tech debt stemming from different organization setup.

Marianne Bellotti writes about being able to predict several key details of an organization's problem by just looking at people's titles meeting her for talking about legacy modernization and by looking at the organzation chart of the company.
She, furthermore, explains that "[...] the types of problems organizations have are heavily influenced by their incentive structure and the easiest way to figure out their incentive structure is by looking at the org chart." {%cite Bellotti2021 %}
The incentive structure is driving and shaping the organization, because it drives and shapes what the organization prioritizes in the day to day work and how people in the organization get ahead.
The tech debt is, then, going to accrue in the day to day work of people in the organization due to their priorities {%cite Bellotti2021 %}.

The incentive structure is one way how the organization influences software architecture.
There are further things such as previous experiences, knowledge, politics, and maturity of the organization.
The organization is shaping the organization's architecture in various ways.
With a little bit of background knowledge, you can understand the mechanisms how an organization influences the software architecture of an application and organization.
Also, you can make use of the mechanisms to influence the organization and software architecture via setting incentives or simply architecting better solutions for your organization (see also: [the article about Conway's Law and the Inverse Conway Maneuver]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-II-conway %}) or [the article about the Team Topologies approach]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-IV-team-topologies-approach %})).

In the [next section](#examples-from-the-real-world), we will first give you some real-world examples about those interdepencies between organization and architecture.

## Examples from the Real World

In this section, I will give you two examples from my work life where I try to explain you the different interdepencies between an organization and its architecture.

 * Knowledge gaps due to complex architecture (people not talking to each other) {% cite Matsudaira2016 %} also related: {% cite Pureur2022 %}
 * Important sub-components are not maintained
 * Sub-optimal solutions due to wrong organization
 * Burry inefficient processes with new tools/technology -> funny Cloud processes image

Other suggestions ([https://www.kambda.com/main-software-architecture-issues-and-challenges/](https://www.kambda.com/main-software-architecture-issues-and-challenges/)):
 * A Company’s Maturity -> Example HAW
 * No Budget Allocation
 * Lack of Personnel
 * Communication

### Architecture does not Follow Organization



### Architecture Determines the Relationship of Teams

As an architect at a retail company, I was involved in a strategical project where two teams should develop a brand new solution to model terraces, fences, etc. for a customer's garden.
From these models, the application ought to derive a construction plan and a bill of material, so that you could go to the retail company, buy the parts from the bill of material, and, then, construct the terrace or fence.
The two teams that should develop the solution, were a product team being responsible to build the customer-facing parts and a support team maintaining master data required as input for the purposes of the new solution.

Unfortunately, both teams - including me ;-) - had different ideas of the overall software architecture.
There were different architecture proposals leading to different degrees of dependencies between those two teams.
One architecture proposal was about to intertwine both teams in a way that both teams would have to be merged as otherwise major organizational inefficiencies would arise.
Another architecture proposal considered both teams to stay independent but required to change the overall process of master data management.
So, there were different architecture proposals making the trade-off between changing the team structure or the business processes.
What architecture should we choose?

When, for example, two teams of an organization are architecting a new solution, they may come up with two components where each component is maintained by one of the teams.
From such an architecture, different architecture challenges may arise which you can also predict when you know about the mechanisms laying behind.
Initially, this architecture may work well, but when team priorities shift or the organization changes, the architecture may be difficult to be maintained.
All this

TODO:
[Conway's Law]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-II-conway %})
[Domain-driven Design]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-III-domain-driven-design %})
[Team Topologies approach]({% post_url 2021-12-26-interdependencies-organization-and-architecture_part-IV-team-topologies-approach %})

### Tensions after Reorganization

"We often see how inattention to the law can twist system architectures. If an architecture is designed at odds with the development organization's structure, then tensions appear in the software structure." {% cite Fowler2022 %}

When I was working at a travel company, that travel company was restructuring multiple times during my time there.
The travel company was driven by technology as the business was enabled by technology.
Unfortunately, I think that the company was not doing well with most of the restructurings.
The example I will give you, is a restructuring from the beginning of 2017.
The reason is that the restructurings were well planned on an organizational level, but the company forgot the architectural and technical level.
The business goal was to change all the teams to be

 * Forgot many core systems to be moved to the new organization
 * Suboptimal solutions 

## Summary

TODO

## References

{% bibliography --cited %}
