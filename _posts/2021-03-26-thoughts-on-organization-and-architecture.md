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
"Architecture, plans, and processes are all vital coordination mechanisms in software projects." {% cite Herbsleb1999 %}

This article is definitely not the first article about interdependencies of organization and architecture.
In {% cite Wolff2020 %} (the YouTube video is, however, only available in German), {% cite Ardalis2020 %}, and {% cite Skelton2020 %}, the authors describe the different aspects of interdependencies between an organizational structure and software architecture in terms of the modules and components.

# Inverse Conway Maneuver

## Domain-driven Design

## Other Influence Factors

# References

{% bibliography --cited %}
