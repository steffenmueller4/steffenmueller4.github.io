---
layout: post
date:   2022-04-19 14:02:30 +0100
title: "Building an Event-Driven Microservice Application"
categories:
  - Architecture
  - Microservices
  - Domain-Events
  - Domain-Driven Design
published: true
---
In August/October 2021, we have begun to build a completely new application which aimed as a substitution for a former web application at [www.huk-autoservice.de](https://www.huk-autoservice.de).
When I have started to plan the new application, it was already clear that I wanted to go towards an event-driven application in the background.
This article summarizes my impressions and learnings from building this application in the last months.

## The Beginning

When I have started [HUK-Autoservice](https://www.huk-autoservice.de), a corporate startup and 100% subsidary of [HUK-COBURG](https://www.huk.de/), in August 2021, it was crystal clear that the company is rather not an established company with an established development department and stable processes.
I had to start to recruit my development team and, furthermore, lead the development supported by an external agency in October 2021.
Overall the plans of my boss with [HUK-Autoservice](https://www.huk-autoservice.de) were quite crazy: Our goal was to build an entirely new product as a greenfield project in the Cloud with completely new processes within only a few months - ca. 6 months to be precise starting on 18th of October 2021.
The ultimate deadline was the 29th of March at which our new product was intended to go live replacing the existing application at [www.huk-autoservice.de](https://www.huk-autoservice.de) that we inherited from a corporate department of the [HUK-COBURG](https://www.huk.de/).

Essentially, the plans made clear that we should rather use rock-solid technology and architecture to not risk our neat timetable.
I remembered the discussions about monoliths vs. microservices in startups and when to use what (see, e.g.: {% cite Tilkov2015 %}).
Other discussions were around going with a dedicated backend and frontend or going full-stack with Node.js.
Anyways, we wanted to go towards an event-driven microservice-style application to leverage flexibility and achieve a pluggable, a loosely coupled application, etc. (see also: {% cite Bellemare2020 %}).

## The Whole Development in a Nutshell

When we have started with the development in October 2021, we started to develop a _domain model_ (see also: [this section](#the-domain-model)).
Based on [Domain-driven Design (DDD)](https://en.wikipedia.org/wiki/Domain-driven_design), a domain model is a software model of the business domain typically containing well-known nouns – often implemented as an object model.
Such a domain model acts as a _ubiquitous language_ to improve the communication between software developers and domain experts within a _bounded context_.
The bounded context encapsulates a certain set of assumptions, a common ubiquitous language, and a particular domain model in a coherent environment.
It is used for defining conceptual boundaries between applications/microservices {% cite Vernon2016 %}, {% cite Fowler2014 %}.
In general, there is the rule of thumb that there is one microservice per bounded context, sometimes there are more microservices per bounded context, but you should rather not have one microservice dealing with two or more bounded contexts.

Collectively, we then defined _domain events_ in this domain model.
A domain event is, following Vaughn Vernon's definition, a record of a business-significant occurrence in a bounded context {% cite Vernon2016 %}.
In the [HUK-Autoservice](https://www.huk-autoservice.de) context, such a record of a business-significant occurrence is, for example, a _booking_ of a car service such as an oil change (see also: [this section](#the-domain-model)).
The booking domain event is raised by our microservice handling the backend work of our core booking userflow when a customer books a car service.
The event is essential for a lot of other services, applications, and departments such as our support team which needs to know about the bookings of a customer to handle support cases when a customer calls them.
Furthermore, the bookings of a customer are relevant for the product and the marketing team and many more to analyze, improve, and advertize our product.

While we were implementing the booking domain event, we soon saw that such a booking can have different states in our domain such as initially _created_, _paid_, _upcoming_, or _finalized_.
For example, a customer can book a car service (created state) and pay it online via credit card (paid state), but does not show up in the garage.
So, the booking stays in the upcoming state and is not finalized.
Maybe, the customer then want to get reimbursed.
These state changes of the booking domain event, thus, had to be communicated.

Although we had to cross a lot of obstacles during the entire development, we eventually came up with a flexible, loosely coupled, and pluggable solution based on this event-driven microservices approach.
The core microservice that emits the booking domain event is not directly connected with the other systems involved such as the Customer Relationship Management (CRM) tool that the support team uses.
The development team developed another independent microservice that listens to the domain events and uses the API of the CRM system to make the booking information available to the support team.
Another microservice listening to the booking domain events cummulates business metrics for the product team.
Soon, we will implement a data lake to which the booking domain events will be written to persist them for further analytics.

In the next sections, you can read about further details of the overall solution such as the [domain model](#the-domain-model) or the [actual architecture](#the-actual-architecture).

## The Domain Model

## The Actual Architecture

Technically, we decided to go with Kafka as an event broker (see also: {% cite Bellemare2020 %} for the difference between a message and an event broker).
Following the recommendation of Adam Bellmare in {% cite Bellemare2020 %}, we defined the domain event messages explicitely via [Protocol Buffers](https://developers.google.com/protocol-buffers).

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autoservice](https://www.huk-autoservice.de) as well as the project partners [Edenspiekermann](https://www.edenspiekermann.com) and [foobar Agency GmbH](https://foobar.agency) for the awesome work.