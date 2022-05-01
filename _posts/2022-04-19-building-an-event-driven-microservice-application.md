---
layout: post
date:   2022-04-19 14:02:30 +0100
title: "Impressions and Learnings from Building an Event-Driven Microservice Application"
categories:
  - Architecture
  - Microservices
  - Domain-Events
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

Collectively, we then defined _domain events_ in this domain model - with a set of experts, we conducted an event storming workshop which served as a basis (see also, e.g.: {% cite WikipediaEventStorming2022 %}, {% cite Stenberg2016 %}).
In general, a domain event is, following Vaughn Vernon's definition, a record of a business-significant occurrence in a bounded context {% cite Vernon2016 %}.
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

In the next sections, you can read about further details of the overall solution such as the [domain model](#the-domain-model) or the [actual architecture](#the-actual-architecture).

## The Domain Model

![Partial Domain Model of Car Services Domain](/assets/car-services-domain-model.png)

## The Actual Architecture

Technically, we decided to go with Kafka as an event broker (see also: {% cite Bellemare2020 %} for the difference between a message and an event broker).
Following the recommendation of Adam Bellmare in {% cite Bellemare2020 %}, we defined the domain event messages explicitely via [Protocol Buffers](https://developers.google.com/protocol-buffers).

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autoservice](https://www.huk-autoservice.de) as well as the project partners [Edenspiekermann](https://www.edenspiekermann.com) and [foobar Agency GmbH](https://foobar.agency) for the awesome work.