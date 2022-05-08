---
layout: post
date:   2022-04-19 14:02:30 +0100
title: "Learnings from Building an Event-Driven Microservice Application"
categories:
  - Architecture
  - Microservices
  - Event-Driven Architecture
  - Domain-Driven Design
published: true
---
In August/October 2021, we have begun to build a completely new application which aimed as a substitution for a former web application.
When I have started to plan the new application, it was already clear that I wanted to go towards an event-driven application in the background.
This article summarizes my impressions and learnings from building this application based on event-driven microservices in the last months.

## The Beginning

When I have started in my current company, a corporate startup and 100% subsidary of an insurance company, in August 2021, it was crystal clear that the company is rather not an established company with an established development department and stable processes.
I had to start to recruit my development team and, furthermore, lead the development of an entirely new product.
Overall, the plans were quite crazy: Our goal was to build the entirely new product as a greenfield project in the Cloud including new processes within only ca. 6 months (start of development was October 2021).
The ultimate deadline was the 29th of March 2022 at which our new product was intended to go live replacing the existing application that we inherited from a corporate department of the insurance company.

Essentially, the plans made clear that we should rather use rock-solid technology and architecture to not risk our tight timetable.
I remembered the discussions about monoliths vs. microservices in startups and when to use what (see, e.g.: {% cite Tilkov2015 %}).
Other discussions were around going with a dedicated backend and frontend.
Eventually, we wanted to go towards an event-driven microservice-style application to leverage flexibility and achieve a pluggable, a loosely coupled application, etc. (see also: {% cite Bellemare2020 %}; for more details on the architecture, we refer to [this section](#the-actual-architecture)).

## The Whole Development in a Nutshell

When we have started with the development in October 2021, we started with a _domain model_ (see also: [this section](#the-domain-model)).
Based on [Domain-driven Design (DDD)](https://en.wikipedia.org/wiki/Domain-driven_design), a domain model is a software model of the business domain typically containing well-known nouns of the domain - often implemented as an object model.
Such a domain model also acts as a _ubiquitous language_ to improve the communication between software developers and domain experts within a _bounded context_.
The bounded context encapsulates a certain set of assumptions, a common ubiquitous language, and a particular domain model in a coherent environment.
It is used for defining conceptual boundaries between applications and microservices {% cite Vernon2016 %}, {% cite Fowler2014 %}.
In general, there is the rule of thumb that there is one microservice per bounded context, sometimes there are more microservices per bounded context, but you should rather not have one microservice dealing with two or more bounded contexts {% cite Newman2019 %}.

We then defined _domain events_ in this domain model collectively - we conducted an event storming workshop with some experts which served as a basis (see also, e.g.: {% cite WikipediaEventStorming2022 %}, {% cite Stenberg2016 %}).
Following Vaughn Vernon's definition, a domain event is a record of a business-significant occurrence in a bounded context {% cite Vernon2016 %}.
In the car services domain of my company, such a record of a business-significant occurrence is, for example, a _booking_ of a car service such as an oil change (see also: [this section](#the-domain-model)).
Concretely, the booking domain event is raised by our microservice handling the backend work of our core booking userflow when a customer books a car service.
The event is essential for a lot of other services, applications, and departments such as our support team which needs to know about the bookings of a customer to handle support cases when a customer calls them.
Furthermore, the bookings of a customer are relevant for the management, the product, and the marketing team as well as many more teams to analyze, improve, and advertize our product.

While we were implementing the booking domain event, we have seen soon that such a booking can have different states in our domain such as initially _created_, _paid_, _upcoming_, or _finalized_.
For example, a customer can book a car service (created state) and pay it online via credit card (paid state), but does not show up in the garage.
So, the booking stays in the upcoming state and is not finalized.
Maybe, the customer then want to get reimbursed.
These state changes of the booking domain event, thus, had to be communicated.

Although we had to cross a lot of obstacles during the entire development, we eventually came up with a flexible, loosely coupled, and pluggable solution based on this event-driven microservices approach.
The core microservice that emits the booking domain event is not directly connected with the other microservices and systems consuming the event such as the Customer Relationship Management (CRM) tool that the support team uses.
The development team developed another independent microservice that listens to the domain events and uses the API of the CRM system to make the booking information available to the support team.
Another microservice listening to the booking domain events cummulates business metrics for the product team.
Soon, we will implement a data lake to which the booking domain events will also be written to persist them for further analytics.

In the next sections, you can read about further details of the overall solution such as the [domain model](#the-domain-model), the [technical perspective on domain events](#technical-perspective-on-domain-events), or the [actual architecture](#the-actual-architecture).

## The Domain Model

![Partial Domain Model of Car Services Domain](/assets/car-services-domain-model.png)

The partial domain model we came up with is depicted in the above figure (in a freestyled form ;-) ).
The _customer_ is at the center of our domain model.
When the customer wants to book a car service - in our domain model, a _service_ - she searches for either a _garage_ which provides the services or for the specific service such as an _oil change_, a _wheel change_, or an _inspection_ which is provided by a garage.
When the customer selected the garage and the service, she can book the service at the garage - the booking domain event (see also: [here](#the-whole-development-in-a-nutshell)).

In general, each connection between two entities can reveal an interesting domain event.
For example, you may be interested in the domain event _ServiceSelectedEvent_ or _GarageSelectedEvent_ between the customer and the service respectively the garage entity in your business.
We decided to only implement the booking domain event so far, because we had to focus on the essentials back then.
However, we may implement the other domain events soon to better analyze our business.

In sum, the domain model helped us a lot to structure our domain and to come up with relevant domain events.
It is also very good when explaining newcomers our domain and the entities they will deal with.
Especially, the domain model and, thus, the ubiquitous language helped us to speak more precisely with each other.
It helped us to get rid of a lot of synonyms we used in the team.

But when you now want to start your first project with DDD, please be sure to also read about valid criticism.
For example, Stefan Tilkov criticizes the hype about DDD in recent years in the two articles {% cite Tilkov2021 %} and {% cite Tilkov2021a %}.
Furthermore, it can be quite hard to learn DDD - especially, when you start off with Eric Evans book (see also: {% cite Evans2003 %}).
We also did not follow DDD in the purest form when modeling our domain or conducting the event storming workshop - we "freestyled" a lot.
So, please always keep in mind that also other system design approaches can lead to excellent results.
However, I definitely recommend - like Stefan Tilkov: "Make DDD part of your tool set, but make sure you don’t stop there." {% cite Tilkov2021a %}

## Technical Perspective on Domain Events

Technically, we decided to go with [Kafka](https://kafka.apache.org/) as an event broker (see also: {% cite Bellemare2020 %} for the difference between a message and an event broker).
Following the recommendation of Adam Bellmare in {% cite Bellemare2020 %}, we defined the domain event messages explicitely via [Protocol Buffers](https://developers.google.com/protocol-buffers).
At the moment, we do not have a schema registry but are using a central repository storing all event message definitions.
However, we are currently looking at different schema registries such as Confluent's [Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html) which is also available at Github (see: [Confluent Schema Registry for Kafka at Github](https://github.com/confluentinc/schema-registry)).

In a Goto Conference talk in 2017, Martin Fowler differentiates between four patterns of event-driven architecture {% cite Fowler2017 %}:

 1. Event Notifications - the system emitting the event message provides APIs to get the further data about the event. So, the event-receiving system invokes APIs of the event-emitting system to handle state changes {% cite Fowler2017 %}.
 1. Event-carried State Transfer - the event message contains all information about the state change, so the event-receiving system has all the necessary information to react to the state change. In contrast to the Event Notification pattern, the emitting and the receiving systems can live independently from each other, because the receiving system does not have to call an API to get the event details {% cite Fowler2017 %}.
 1. Event Sourcing - instead of storing the state of a business entity in a database, event messages are saved in consecutive order in an event store, and the state of the business entity is then reconstructed by replaying the event messages stored in the event store {% cite Richardson2021 %}.
 1. Command Query Responsibility Segregation (CQRS) - at the heart of CQRS, is the notion that you can use a different model to update information than the model you use to read information. For more information about CQRS, we refer, for example, to {% cite Fowler2011 %} or {% cite Richardson2021a %}.

In general, our system uses the Event-carried State Transfer pattern.
The application still uses databases for storing its state and emits the domain events to Kafka on top of storing the state to the database.
This way, we were able to have a fast pace in the project due to not changing the way people think about building software while also benefitting from sending out domain events.
With all the different people with very different background in the project, the introduction of domain events was hard enough even without the difficult general concepts of Event Sourcing and CQRS (see also: {% cite Fowler2017 %} for criticism about Event Sourcing and CQRS as well as {% cite Fowler2011 %} about CQRS).
In some use cases, we nowadays also use the Event Sourcing pattern.

When looking back to the project, it is essential that your project team understands what you want to achieve with building an event-driven microservices.
They should know what systems you want to integrate.
This is especially required to specify the information that has to be in the event messages.
Furthermore, the team should know the four patterns of event-driven architecture.
This improves the understanding of the entire architecture and leads to better solutions such as using the Event Sourcing pattern for specific use cases.
Also, you should directly think about a Schema Registry for managing your domain event messages.
As soon as the number of microservices increases, you will be happy when you do not have to update all Protocol Buffer definitions or coordinate the rollout.
Last but not least, make sure that your domain event messages are replayable as Adam Bellmare recommends in {% cite Bellemare2020 %}.
For example, our first versions of our Kafka consumers were creating IDs when inserting new entries to some systems, so storing the events were not idempotent and, thus, not replayable.
Please either create the unique IDs in the source system or derive the ID from the event in a deterministic way.
Also, consider to use upserts in the destination system.

## The Actual Architecture

![Partial Architecture of Car Services Application](/assets/car-services-architecture-overview.png)

In the figure above, you can see the partial architecture of the car services application.
The application consists of a [Next.js](https://nextjs.org/) frontend application, two backend applications, a [Kafka](https://kafka.apache.org/) server providing topics for the different event messages such as the booking domain event topic, a Kafka consumer reading all event messages that should be written to the CRM tool, and the CRM tool.

## Conclusions



## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autoservice](https://www.huk-autoservice.de) as well as our project partners [Edenspiekermann](https://www.edenspiekermann.com) and [foobar Agency GmbH](https://foobar.agency) for the awesome work.