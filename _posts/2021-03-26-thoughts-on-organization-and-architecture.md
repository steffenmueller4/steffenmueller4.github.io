---
layout: post
date:   2021-03-26 10:11:08 +0100
title: "Interdependencies between Organization and Software Architecture (Part 1)"
categories:
  - Architecture
  - Domain-driven Design
  - Thoughts
  - Organization
published: true
---
How does the organization of an organizational unit influence the software architecture of applications and vice versa?
There are different rules of thumb and theories such as Conway's Law, the Inverse Conway Maneuver, and methods which indicate the interdependencies.
In this article, we will summarize those basics of the interdependencies between the organization and software architecture.
It is the first part (part 1) of an article series of 2 articles about the interdependencies of organization and software architecture.

# Conway's Law

The basic understanding of the interdependencies between an organizational structure and software architecture was first explained by Melvin Conway in Conway's Law {% cite ConwayUrl2021 %} in 1967.
Conway stated that "Any organization that designs a system (defined broadly) will produce a design whose structure is a copy of the organization's communication structure." {% cite ConwayUrl2021 %}
Furthermore, he concluded that "[...] the interface structure of a software system necessarily will show a congruence with the social structure of the organization that produced it." {% cite ConwayUrl2021 %}
Other people (Eric S. Raymond and Tom Cheatham) explained this law more plastically by giving examples based on Conway's Law: ["If you have four groups working on a compiler, you'll get a 4-pass compiler" (Raymond)](http://catb.org/%7Eesr/jargon/html/C/Conways-Law.html) or "If a group of N persons implements a COBOL compiler, there will be N-1 passes. Someone in the group has to be the manager." (Cheatham)

Specifically in combination with Parnas' approach to modularize software to clarify responsibilities described in {% cite Parnas1972 %}, Conway's Law was used to explain a lot of organizational issues and recommendations in software projects and organizations in recent decades.
For example, Herbsleb and Grinter based their recommendations of allocating teams and modules properly in geographically distributed software development on Conway's Law {% cite Herbsleb1999a Herbsleb1999 %}.
Herbsleb and Grinter state that work should be assigned to different teams and sites according to the "[...] greatest possible architectural separation in a design that is as modular as possible." {% cite Herbsleb1999a %}
But such an allocation should only be done if the product and the development processes are stable and well-understood.
Then, "architecture, plans, and processes are all vital coordination mechanisms in software projects." {% cite Herbsleb1999 %}

In 2007/2012, MacCormack, Baldwin, and Rusnak published a study where they investigated about the validity of Conway's Law {% cite MacCormack2012 %}.
In their study, they compared open source projects and communities with commercial product development teams.
Based on Conway's Law, they assumed open source software (OSS) products to be more modular than commercial software products, because OSS products are developed in "loosely-coupled" organizational units and often do not have formal organisation structures to govern development activities.
Subject of their investigations were 12 products where MacCormack, Baldwin, and Rusnak build pairs of similar products such as [GnuCash 1.8.4](https://www.gnucash.org) vs. MyBooks in the category of financial management software, [AbiWord](https://www.abisource.com/) vs. StarWriter (see also: [StarOffice](https://de.wikipedia.org/wiki/StarOffice#Versionen)) in the category of word processing, Linux 2.1.32 vs. Solaris in the first of two categories of operating systems, etc.
Based on their analysis, they found strong evidence that the "[...] product's architecture tends to mirror the structure
of the organization in which it is developed [...]" {% cite MacCormack2012 %} and, thus, Conway's Law holds true oftentimes.

Although MacCormack's, Baldwin's, and Rusnak's study definitely has their limits in their approach, in explaining the different causalities involved, or checking other properties than modularity, managers should consider the influences of the organizational structure and goals on product design and architecture.
So, when the organizational unit in which you are building a software product is siloed and organized based on a strict functional team design such as a separation into frontend, backend, and operations teams, you will very likely not get an overly customer-focused product which is considering a DevOps approach.

# Inverse Conway Maneuver

Due to the interdepencies between organization and architecture stated by Conway's Law, the Inverse Conway Maneuver emerged in recent time.
The Inverse Conway Maneuver is about making use of and, therefore, "inverting" Conway’s Law for improving the architecture of a product.
So, the core idea is to structure an organizational unit so that a desired architecture emerges.

The term Inverse Conway Maneuver was coined by Leroy and Simons in an article in 2010 {% cite Leroy2010 %}.
Their goal was to change organizations in order to build better software based on interdisciplinary independent teams which can collaborate with business effectively.
They wanted to change the organization's communication structures - please remember that Conway's Law phrased that system's architecture is a copy of the organization's communication structure - using technology.
"Conway’s Law, therefore, does work both ways. Organizational structures impact system design, and system architectures impact organizational structures as well." {% cite Bloomberg2015 %}

# Domain-driven Design

The recent rise of microservice architectures often lead to problems of finding the right scope for those microservices when migrating old legacy application to microservices or building new applications in the microservice style.
Thereby, overlapping or unknown domains as well as unclear interrelationships between teams were often the underlying reasons of such problems.
Thus, the underlying reasons were of an organizational nature.

Here, Domain-driven Design (DDD) can help.
Originally developed by Eric Evans in the 2000er years (see also: {% cite Evans2003 %}), DDD is about designing software based on models of the domain.
The domain models, therefore, act as a Ubiquitious Language and as a conceptual foundation for the design of the software {% cite Fowler2014 %}.

A central pattern in DDD is the Bounded Context.
Bounded Contexts should encapsulate a certain set of assumptions, a common Ubiquitous Language, and a particular domain model in a coherent environment.
Via those Bounded Contexts, the software can be divided into smaller parts with clear boundaries and interfaces between each other.

DDD, furthermore, tries to define the interfaces between those smaller parts - so, relationships between Bounded Contexts - in a variety of ways {% cite Fowler2014 %} (see also: {% cite Brandolini2009 %}).
Via so-called Context Mapping, the

In a nutshell, DDD can help you to map interdependencies between organization and software architecture and, thus, to tailor organizations, teams, and software.

# Other Influence Factors

# Further Articles and Talks about this Topic

This article is definitely not the first article about the interdependencies of organization and architecture.
In {% cite Wolff2020 %} (it is only available in German), {% cite Ardalis2020 %}, and {% cite Skelton2020 %}, the authors describe the different aspects of interdependencies between an organizational structure and software architecture in terms of the modules and components.

In {% cite Bloomberg2015 %}, Bloomberg summarizes Conway's Law and the Inverse Conway Maneuver in the context of the DevOps movement.

# References

{% bibliography --cited %}
