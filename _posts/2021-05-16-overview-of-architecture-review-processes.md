---
layout: post
date:   2021-05-29 09:02:08 +0100
title: "Overview of different Architecture Review Processes"
categories:
  - Architecture
  - Organization
  - Architecture Review Process
published: true
---
Recently, I was asked about what software architecture review processes exist in order to better steer architecture.
An architecture review aims at different goals such as finding software design issues early in the development before they get costly.
Architecture review processes, for example, formalize different steps.
They, furthermore, define input and output to/from architecture reviews.
This article describes the different architecture review process approaches.

## What are Architecture Reviews and Architecture Review Processes?

An architecture review, in a nutshell, is a mechanism for increasing the likelihood that a software/system architecture will be complete, consistent, and, thus, good {% cite Maranzano2005 %}.
A good software architecture is important, otherwise the development can become slower.
It can get more expensive to add new capabilities in the future.
High internal quality, on the other side, can lead to faster delivery of new features; simply, because there is less cruft to get in the way {% cite Fowler2019 %}.

Essentially, architecture reviews aim at {% cite Maranzano2005 %}:
  1. finding software design problems early in development before they get costly.
  1. building projects based on best practices and transfer this knowledge across the organization.
  1. improving the organization's software quality and operations (-> documentation).

Therefore, architecture review processes formalize different steps, the parties involved, or input and output to architecture reviews.
Over the last decades, different architecture review processes have emerged.

As every such process can be modified and adapted to the unique requirements of a specific company, we will focus on three different prototypical processes that are described in literature:
  1. The "Classical" Architecture Review process explained by Maranzano et al. in {% cite Maranzano2005 %}.
  1. The Architecture Decision Records (ADR) initially described by Nygard in {% cite Nygard2011 %}.
  1. The Lightweight Request for Comment (RFC)/Design Document approach explained in {% cite Ubl2020 %}, {% cite Winters2020 %}, {% cite Orosz2020 %}, {% cite Orosz2021 %}, {% cite Zimmermann2019 %}, {% cite Gonchar2020 %}, and {% cite Mozilla2020 %} from the perspectives of different organizations - sometimes called Lightweight RFC and sometimes Design Document approach. The approach has also been mentioned in the ThoughWorks Tech Radar Vol. 24 trial area as Lightweight RFC approach in {% cite ThoughtWorks2021 %}.

In the next sections, we will describe these three different prototypical architecture review processes.
But before we start to explain the prototypical architecture review processes, we have to look shortly at different ways to organize architecture work in an organization.

## Who is Organizing Architecture in your Organization

In {% cite Hohpe2021 %}, Hohpe explains the different options of organizing architecture in organizations.
He summarizes four options using a model based on Plöd as well as Toth {% cite Toth2020 %}:
  1. Benevolent dictator: An architect or architect team tells the developers what and how to do architecture.
  1. Primus inter pares: Architects are embedded into development teams where they are just-another-team-member but focus on architecture.
  1. Architecture without architects: Architecture work is a shared responsibility and done within teams by the developers.
  1. Inmates running the asylum: Although, this option may look like the previous option "architecture without architects", the difference is that nobody is really doing architecture. This often results in a complex architecture with a lot of cruft and long development cycles.

Hohpe also suggests that different architecture maturity stages of an organization may require a different choices.
For example, the "benevolent dictator" may be required when there is a lot of cruft accumulated before going over to the option 3 (architecture without architects).
Especially, the differences between the options 3 (architecture without architects) and 4 (inmates running the asylum) may be quite fluid and not recognizable easily {% cite Hohpe2020 %}.

In a nutshell, you shoud consider what architecture organization model is persistent in your organization.
The different architecture review processes include different parties involved and, thus, different pros and cons.
The parties involved in the processes such as the Architecture Review Board in the "Classical" Architecture Review process can be represented by a group of knowledgable architects (option 1 - benevolent dictator), a well-organized architecture guild based on option 3, or even a group of inmates running the asylum (option 4).
However, the people involved in the parties of the processes define the quality of the review output and, thus, the quality of an organization's architecture.

Also, some architecture review processes may not be possible in your organization due to political reasons.
A group of architects (option 1 - benevolent dictator) may not be interested in giving up power to strengthen development teams power based on processes suggesting more the option 2 (primus inter pares) or 3 (architecture without architects).
We will discuss such issues in more detail in the respective sections of the different processes.

In the next section, we describe the different prototypical architecture review processes.

## The "Classical" Architecture Review Process

The "Classical" Architecture Review process is described by Maranzano et al. in a paper based on common architecture review processes at AT&T, Avaya, Lucent, and Millenium Services {% cite Maranzano2005 %}.
The paper stems from 2005, the idea is based on AT&T's practices from the late 1980s.
A lot of established companies (still) use this approach in some variation.

### Parties

The approach considers three primary parties in an architecture review:
  1. the project team (requested architecture review),
  1. the review team (consists of experts, assembled for the review on the basis of their expertise, their independence from the specific project, and their ability to conduct themselves appropriately in a potentially difficult interpersonal situation), and
  1. the architecture review board (ARB) (a standing team that oversees the review process and its effect on the organization).

### Process

The review process follows the roughly four phases.
The specific implementation may vary.
  1. Screening Phase: The project team requests a review. The project staff and ARB review the request to determine whether a review would benefit the project. If they recommend a review, the ARB selects a "review angel" (supporter for the project team in cases of issues political issues, etc. that may arise during the review) to oversee the project’s review process.
  1. Preparation Phase: The ARB selects a "review team", including a "review leader", and works with the project to determine the number of reviews and the initial review’s date and agenda. The staff, project team, review leader, and review angel verify that the project has an adequately clear problem statement and appropriate documentation.
  1. Review Meeting Phase: During the review, the project team presents its problem statement and outlines how the proposed architecture solves it. The reviewers ask questions and record issues they believe could make the project an incomplete or inadequate solution to the problem. Finally, a report is generated and presented to the project team. Furthermore, management alerts can be raised, etc.
  1. Follow-Up Phase: The review team delivers a report with the review’s findings to the project team within 15 days of the review. The project team (and, if a management alert has been raised, the management) must respond within two weeks.

### Artifacts

Formalized process to make the review work Architecture review checklist(s).
Input to the review such as system requirements, functional requirements, etc.
Output from the review such as the review report, an optional management alert letter, an optional set of issues, etc.

### Conclusion

The "classical" approach is a well-established and formalized process which is (still) widely used.
Especially, bigger companies or, at least, companies with dedicated architects often make use of such a process in some variation.

On the one hand, the formalized process as well as the clear roles within the process help to achieve the goals of architecture reviews.
Also, there are different options to vary the process in order to, for example, have less parties involved or reduce the overhead.
In some companies, there is, for instance, no ARB or review team but an architecture guild which is performing architecture reviews instead.
Another option is to reduce the overhead of the artifacts and, therefore, only give a presentation about the architecture to be reviewed - however, I think that there should be a written architecture document.

On the other hand, the formalized process and the overall overhead for the "classical" approach is also often the point to be critizied mostly.
The overall process makes a lot of overhead for smaller projects or architecture changes which have to be reviewed.
In sum, the entire original approach does not appear to be very agile, but there are also ways to improve this as well.

## Architecture Decision Records

Architecture Decision Records (ADR) were initially proposed by Nygard in 2011.
Nygard stated that architecture in an agile context has to be described and defined differently.
In an agile context, decisions are made step by step alongside the project progress.
They will not be made at once, nor will all of them be done when the project begins.
So, the architecture documentation should also be done incrementally.
This is also supported by the fact that nobody ever reads large documents {% cite Nygard2011 %}.

Therefore, Nygard proposes ADR as small documents which concentrate on tracking the motivation, rationale, and consequences behind certain architectural decisions made during different points in time in the project in a very structured way.
"We will keep a collection of records for 'architecturally significant' decisions: those that affect the structure, non-functional characteristics, dependencies, interfaces, or construction techniques." (Nygard, 2011)
Essentially, the small and structured form of ADR should help finding out about motivation, rationale, and consequences of previous decisions.
The ADR form a "decision log" {% cite ADR2021 %}.

For more information, we refer to [https://adr.github.io/](https://adr.github.io/).

### Parties

Although, the proposal does not really differentiates between parties, you can distiguish between:
  1. the project team or creator of an ADR,
  1. the ADR reviewer(s)

### Process

When there is an architecturally significant decision made, the project team, the involved architect, or - in general - persons who are involved in the decision create the ADR.
ADR can be stored in GIT (there is also tool support available, e.g., [https://github.com/npryce/adr-tools](https://github.com/npryce/adr-tools)) or in a wiki.
For better accessibility from an potentially interested audience, it is recommended to store ADR in a wiki or another public location - changes to the ADR, however, should be tracked.

An ADR typically contains:
  * Title
  * Status
  * Context
  * Decision
  * Consequences
  * Compliance description
  * Notes

An example with a slightly different structure can be found here.
Every ADR is an own small document.
ADR can get an ID and, thus, be referenced in other documentation.
New ADR can change aspects of a previous ADR. If that happens, they can change the status of the previous ADR.

### Artifacts

Just the ADR in a central place per project or at a public place.
Reviews on the ADR should be done on the ADR itself when the ADR is created.
ADR can be combined with other documents such as Design Documents (Kuenzli, 2019).
"A decision record should not be used to try and capture all of the information relevant to an architecture or design topic. [...] The creators of an architecture or design should author a document that describes it in detail (whether facilitated by a guild or not)." {% cite Kuenzli2019 %}

### Conclusion

TODO

## Design Document or Lightweight Request for Comment Approach

Essentially, the Design Document or Lightweight Request for Comment (RFC) approach is about writing a design document as the review artifact and sharing this design document across the developer community in a company with the request to comment and challenge the design.

The approach bases on the strong belief that the community knows more than an individual.
Thus, the entire developer community at a company should be included into the designing of the systems.
Ubl explains the thoughts behind that nicely in {% cite Ubl2020 %}.
He states that "[...] it did establish a relatively uniform software design culture across the company [at Google]." {% cite Ubl2020 %}
Orosz additionally states that the "[...] type of information pushed to people in an organization shapes the culture considerably. [...] [It] sets a tone of trust and responsibility." {%cite Orosz2020 %}

On top of that community thinking, the approach considers the power of the written word.
"Writing and sharing that writing with others creates accountability. It also almost always leads to more thorough decisions." {% cite Orosz2020 %}

Evangelized by Google, Design Documents (DD) are a more informal way of documenting software architecture at a certain point in time {% cite Ubl2020 %} - originally, considered for the design phase but can be applied to any rework of architectural aspects (solution idea) before the actual (code) work is done.
Also, Amazon, Facebook, and Netflix make use of a similar approach {% cite Orosz2021 %}.

Main goal of DD is the communication aspect: A DD should identify issues of a solution idea as early as possible in the project lifecycle, help to achieve consensus around a design in the organization, ensure the consideration of cross-cutting concerns, distribute knowledge about solution ideas, and document the solution.
In order to achieve that, a certain structure has emerged focusing on architecturally important aspects of a solution idea at Google (see also: {% cite Ubl2020 %}):
  * Context and Scope Goals and Non-goals
  * The actual Design
    * System-context Diagram
    * APIs
    * Data Storage
    * etc.
  * Alternatives Considered
  * Cross-cutting Concerns

Thereby, those points are optional and depend on the actual solution idea.
Also, solution ideas may require other aspects to be described - as already explained, DD are informal.
In general, focus in DD should be the discussion of trade-offs of the solution ideas that were considered during decisions.
"Design docs should be sufficiently detailed but short enough to actually be read by busy people." {% cite Ubl2020 %}

Recommendations reach from 1 up to 20 pages depending on the problem and solution idea.
As writing DD is overhead, the decision whether to write a DD comes down to the core trade-off of deciding whether a review is beneficial.
If there are benefits in organizational consensus around a design, a documentation or in having a review from other parties, the extra work of a design doc is worth the effort.

An example, of a DD is available at {% cite Ubl2015 %}.

See also: {% cite Mozilla2020 %}

### Parties

The DD should be written by the team actually working on the solution idea.
The DD should be created during the work on finding the solution idea, before the implementation really starts.

Ubl and Orosz suggest that the DD should be shared with the entire company - or at least with a huge amount of interested people - as soon as the solution idea stabilizes. The interested people should review and discuss the DD and the solution idea to improve it in an company-open and lightweight process.

### Process

Ubl and Orosz suggest roughly the following process (see: {% cite Ubl2020 %} and {% cite Orosz2021 %}):
  1. The team start with the business problem and brainstorm solution ideas. During that phase, the DD shoud be started and iterated rapidly within the team itself until the solution idea/DD stabilizes.
  1. The stable DD should be shared with the company or, at least, with a wider audience of interested people who review the DD and the solution idea in, maybe, multiple rounds of feedback.
  1. "When things have progressed sufficiently to have confidence that further reviews are unlikely to require major changes to the design, it is time to begin implementation." {% cite Ubl2020 %}

### Artifacts

Just the DD and conversations/feedback.
Thereby, the DD should be openly accessible - for example, at a common location in a wiki.

### Conclusion

The DD approach described by Ubl and Orosz

TODO

## Summary

TODO

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to [Andy Grunwald](https://andygrunwald.com/) who helped me to improve this article by reviewing it.