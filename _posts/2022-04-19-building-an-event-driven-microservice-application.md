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

## The Whole Development in an Overview

When we started with the development in October 2021, ...

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autoservice](https://www.huk-autoservice.de) as well as the project partners [Edenspiekermann](https://www.edenspiekermann.com) and [foobar Agency GmbH](https://foobar.agency) for the awesome work.