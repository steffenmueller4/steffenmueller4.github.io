---
layout: post
date: 2023-12-17 07:50:00 +0100
title: "Thinking About Interdependencies between Organization and Software Architecture"
categories:
  - Architecture
  - Organization
published: true
---
As a senior engineer, software architect, engineering manager, etc., we are often facing situations where we realize interdependencies between an organization and software architecture.
Questions that you may ask yourself are, for example: what team should maintain a specific component within a larger architecture or organization?
How to build a proper architecture serving this or that team?
How to (re-)structure teams when facing a bigger architecture rework or a new project?
This article is about how to think about those interdependencies between organization and software architecture.
It should provide a guide for you while setting up an architecture or organization.

## Introduction

Some time ago, I have read Marianne Bellotti's post about [hunting tech debt via org charts](https://bellmar.medium.com/hunting-tech-debt-via-org-charts-92df0b253145) with delight.
Marianne Bellotti writes about being able to predict several key details of an organization's problem by just looking at people's titles meeting her and by looking at the organzation chart of the company.
She, furthermore, explains that "[...] the types of problems organizations have are heavily influenced by their incentive structure and the easiest way to figure out their incentive structure is by looking at the org chart." {%cite Bellotti2021 %}
The incentive structure is driving and shaping the organization, because it drives and shapes what the organization prioritizes in the day to day work and how people in the organization get ahead.
Tech debt, then, accrues in the day to day work of people in the organization due to their priorities {%cite Bellotti2021 %}.

The incentive structure—here, we can distinguish between individual and organizational incentives—is one way how the organization influences software architecture.
There are further influences such as communication structure, previous experiences, knowledge, politics, maturity of the organization, etc.
Thus, the organization is shaping the organization's software architecture in various ways.
With a little bit of background knowledge, you can understand the mechanisms of how an organization influences the software architecture of an application and organization.
Also, you can make use of those mechanisms via setting incentives or considering the different influence factors when architecting better solutions for your organization.

But before we are going into the theory, let's get some examples from real world in the next section.

## Real World Examples

### Software Architecture influences Team Setup and vice versa

Some time ago, I have been involved in a project as a software architect where two teams had to closely work together to build a brand new strategical application.
The first team was a support team which maintained core data required as input for the purposes of the new application that the second team should build and maintain.
Unfortunately, all of us—me, the team members, the team lead, the product owners, and the management—had different ideas about the overall software architecture.
After a couple of meetings, there were different architecture proposals leading to different degrees of dependencies between those two teams.
In total, we had, I believe, five different architecture proposals with different nuances of dependencies between the teams.
One architecture proposal was about to intertwine both teams in a way that both teams would have to be merged, as otherwise major inefficiencies would arise.
Another architecture proposal considered both teams to stay independent but required to change the overall process of data management.

So, what architecture—or oranizational setup—should we choose?
In sum, there were different aspects you could analyze.
There were different incentives for the various stakeholders including the main purpose of existence of one team, different consequences to the organizational setup and communication overhead, etc.
I cannot tell you how the different stakeholders decided and how the architecture looks like eventually because I left the company before the decision was made and the project continued, but we will look at this example from different angles in the next sections.

### Different Drawbacks between Team Setup and Software Architecture

Recently, I have been discussing about redistributing duties and tasks in the sub teams.
With our main product, we have two sub teams: the first sub team takes about the customer-facing application itself, and the second team was supposed to build integrations with our partners (see also: [The architecture of the main product]({% post_url 2022-05-10-building-an-event-driven-microservice-application %}#the-architecture)).

Amazon Example -> Monolith + Danger of distributed Monolith + Too small Microservices = Development Overhead

### Conclusion

As this small example already shows you, there are various interdependencies between organization and software architecture.
In order to properly think about and manage them, we first need to understand them properly.
A good start to do so, is to look at [Conway's Law](#conways-law) and the [Inverse Conway Maneuver](#inverse-conway-maneuver).
Furthermore, we will look at strategic Domain-driven Design (DDD), before we try to conclude the limitations and things to also look out for.
Let's start with [Conway's Law](#conways-law) in the next section.

## Conway's Law

Martin Fowler states in {% cite Fowler2022 %} about Conway's Law: "Pretty much all the practitioners I favor in Software Architecture are deeply suspicious of any kind of general law in the field [...] But if there is one thing they all agree on, it's the importance and power of Conway's Law. Important enough to affect every system I've come across, and powerful enough that you're doomed to defeat if you try to fight it." {% cite Fowler2022 %}

In 1967, Melvin Conway stated in Conway's Law {% cite ConwayUrl2021 %} that any "[...] organization that designs a system (defined broadly) will produce a design whose structure is a copy of the organization's communication structure." {% cite ConwayUrl2021 %}
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
Besides that, changing the organization should not be a task of software enigineers or architects—not even line managers.
Vice versa it should not be the management's task to define the softare architecture solely.
Eberhard Wolff nicely describes those issues regarding the Inverse Conway Maneuver in {% cite Wolff2023 %} (unfortunately, only available in German).

## Strategic Domain-driven Design

TODO

## Other Incluence Factors

TODO 

## Summary

This article is definitely not the first article about the interdependencies of organization and architecture.
In {% cite Wolff2020 %} (it is only available in German), {% cite Ardalis2020 %}, and {% cite Skelton2020 %}, the authors describe the different aspects of interdependencies between an organizational structure and software architecture in terms of the modules and components.

In {% cite Bloomberg2015 %}, Bloomberg summarizes Conway's Law and the Inverse Conway Maneuver in the context of the DevOps movement.

## References

{% bibliography --cited %}