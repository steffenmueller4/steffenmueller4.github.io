---
layout: post
date: 2022-12-26 07:50:00 +0100
title: "Conway's Law or How to Think About Interdependencies between Organization and Software Architecture"
categories:
  - Architecture
  - Organization
  - Conway
published: true
---
Some time ago, I have read Marianne Bellotti's post about [hunting tech debt via org charts](https://bellmar.medium.com/hunting-tech-debt-via-org-charts-92df0b253145) with delight.
And... yes, I observed similar things in my work experience.
As a senior engineer, an architect, or an engineering manager, you are often facing situations where you realize interdependencies between your organization and software architecture.
What team should maintain a specific component within a larger architecture or organization?
How to (re-)structure teams when facing a bigger architecture rework or a new project?
This article is about Conway's Law and the Inverse Conway Maneuver which can help you to think about interdependencies between organization and software architecture as well as guide you while setting up an organization or bigger architecture.

## Introduction

Some time ago, I have read Marianne Bellotti's post about [hunting tech debt via org charts](https://bellmar.medium.com/hunting-tech-debt-via-org-charts-92df0b253145) with delight.
And... yes, I observed similar things in my work experience.
After working as an IT consultant in the public sector, as a research associate in a publicly founded research project, and in several product-focussed companies in various roles, I can definitely back Marianne Bellotti's observations that there is common tech debt stemming from different organization setup.

Marianne Bellotti writes about being able to predict several key details of an organization's problem by just looking at people's titles meeting her and by looking at the organzation chart of the company.
She, furthermore, explains that "[...] the types of problems organizations have are heavily influenced by their incentive structure and the easiest way to figure out their incentive structure is by looking at the org chart." {%cite Bellotti2021 %}
The incentive structure is driving and shaping the organization, because it drives and shapes what the organization prioritizes in the day to day work and how people in the organization get ahead.
The tech debt is, then, going to accrue in the day to day work of people in the organization due to their priorities {%cite Bellotti2021 %}.

The incentive structure is one way how the organization influences software architecture.
There are further things such as previous experiences, knowledge, politics, and maturity of the organization.
The organization is shaping the organization's architecture in various ways.
With a little bit of background knowledge, you can understand the mechanisms how an organization influences the software architecture of an application and organization.
Also, you can make use of the mechanisms to influence the organization and software architecture via setting incentives or simply architecting better solutions for your organization.

When I have been involved in a project as an architect where two teams had to closely work together to build up a brand new strategical application.
The first team was a support team that maintained core data required as input for the purposes of the new application that the second should build and maintain.
Unfortunately, both teams - including me ;-) - had different ideas of the overall software architecture.
There were different architecture proposals leading to different degrees of dependencies between those two teams.
One architecture proposal was about to intertwine both teams in a way that both teams would have to be merged as otherwise major inefficiencies would arise.
Another architecture proposal considered both teams to stay independent but required to change the overall process of data management.
What architecture should we choose?

## Conway's Law

The basic understanding of the interdependencies between an organization and software architecture was first explained by Melvin Conway in Conway's Law {% cite ConwayUrl2021 %} in 1967.
Conway stated that any "[...] organization that designs a system (defined broadly) will produce a design whose structure is a copy of the organization's communication structure." {% cite ConwayUrl2021 %}
Furthermore, he concluded that "[...] the interface structure of a software system necessarily will show a congruence with the social structure of the organization that produced it." {% cite ConwayUrl2021 %}
Other people such as Raymond and Cheatham explained this law more plastically by giving examples based on Conway's Law: ["If you have four groups working on a compiler, you'll get a 4-pass compiler" (Raymond)](http://catb.org/%7Eesr/jargon/html/C/Conways-Law.html) or "If a group of N persons implements a COBOL compiler, there will be N-1 passes. Someone in the group has to be the manager." (Cheatham)

Specifically, in combination with Parnas' approach to modularize software and clarify responsibilities described in 1972 in {% cite Parnas1972 %}, Conway's Law was used to explain a lot of organizational issues and recommendations in software projects and organizations in recent decades.
For example, Herbsleb and Grinter based their recommendations of allocating teams and modules properly in geographically distributed software development on Conway's Law {% cite Herbsleb1999a Herbsleb1999 %}.
Herbsleb and Grinter state that work should be assigned to different teams and sites according to the "[...] greatest possible architectural separation in a design that is as modular as possible." {% cite Herbsleb1999a %}
But such an allocation should only be done if the product and the development processes are stable and well-understood.
Then, "architecture, plans, and processes are all vital coordination mechanisms in software projects." {% cite Herbsleb1999 %}

In 2007/2012, MacCormack, Baldwin, and Rusnak published a study where they investigated about the validity of Conway's Law {% cite MacCormack2012 %}.
In their study, they compared open source projects and communities with commercial product development teams.
Based on Conway's Law, they assumed open source software (OSS) products to be more modular than commercial software products, because OSS products are developed in "loosely-coupled" organizational units and often do not have formal organization structures to govern development activities.
Subject of their investigations were 12 products where MacCormack, Baldwin, and Rusnak build pairs of similar products such as [GnuCash 1.8.4](https://www.gnucash.org) vs. MyBooks in the category of financial management software, [AbiWord](https://www.abisource.com/) vs. StarWriter (see also: [StarOffice](https://de.wikipedia.org/wiki/StarOffice#Versionen)) in the category of word processing, Linux 2.1.32 vs. Solaris in the first of two categories of operating systems, etc.
Based on their analysis, they found strong evidence that the "[...] product's architecture tends to mirror the structure
of the organization in which it is developed [...]" {% cite MacCormack2012 %} and, thus, Conway's Law holds true oftentimes.

Although MacCormack's, Baldwin's, and Rusnak's study definitely has their limits in their approach, in explaining the different causalities involved, or in checking other properties than modularity, managers should consider the influences of the organizational structure and goals on product design and architecture.
When the organization in which you are building a software product is siloed and organized based on a strict functional team design such as a separation into frontend, backend, and operations teams, you will very likely not get an overly customer-focused product which is considering a DevOps approach.
In general, Conway's Law as well as MacCormack's, Baldwin's, and Rusnak's research, however, are rather explaining the issues that result from a specific organizational structure that is in place.
It does not give you advices how to set up a better organizational structure.

## Inverse Conway Maneuver

Due to the interdepencies between organization and architecture stated by Conway's Law, the Inverse Conway Maneuver emerged in recent time.
The Inverse Conway Maneuver is about making use of and, therefore, "inverting" Conway’s Law for improving the architecture of a product.
So, the core idea is to structure an organizational unit so that a desired architecture emerges.

The term Inverse Conway Maneuver was first used by Leroy and Simons in an article in 2010 {% cite Leroy2010 %}.
Their goal was to change organizations in order to build better software based on interdisciplinary independent teams which can collaborate with business effectively in the beginning of the DevOps movement.
Goal was to change the organization's communication structures driven by technology.
"Conway’s Law, therefore, does work both ways. Organizational structures impact system design, and system architectures impact organizational structures as well." {% cite Bloomberg2015 %}

Later on, the idea of the Inverse Conway Maneuver became more popular when microservices were on the rise.
For example, James Lewis, Technical Director at Thoughtworks, used the term Inverse Conway Maneuver in his talk at the Goto Con 2015 {% cite Lewis2015 %} (see also: {% cite Lewis2014 %}).
Microservices should be designed "[...] as suites of independently deployable services [...]" and built "[...] around business capability, automated deployment, intelligence in the endpoints, and decentralized control of languages and data." {% cite Lewis2014 %}
Teams that build and maintain microservices should be cross-functional and organized around products - not projects - that are aligned with the customer.
To achieve that, the organization should to be chunked up "[...] from team to value stream to line of business to organization [...]" {% cite Lewis2015 %} - so, the Inverse Conway Maneuver.

While nearly every company builds architectures based on the Microservices architecture style nowadays, still not everybody has understood that organization and architecture cannot be changed isolated.

## Summary

This article is definitely not the first article about the interdependencies of organization and architecture.
In {% cite Wolff2020 %} (it is only available in German), {% cite Ardalis2020 %}, and {% cite Skelton2020 %}, the authors describe the different aspects of interdependencies between an organizational structure and software architecture in terms of the modules and components.

In {% cite Bloomberg2015 %}, Bloomberg summarizes Conway's Law and the Inverse Conway Maneuver in the context of the DevOps movement.

## References

{% bibliography --cited %}