---
layout: post
date:   2022-10-13 20:14:15 +0100
title: "With Four Key Metrics towards Development Excellence"
categories:
  - DevOps
  - KPI
  - Development
  - Culture
published: true
hero_image: "/assets/hero-four_key_metrics.svg"
---
In an article about why technology matters more and more for companies, Gary O'Brien and Mike Mason mention Continous Delivery (CD) and applied DevOps practices as one of five key factors for a company's (future) success {% cite OBrien2020 %}.
Also, Jon Moore and Marty Cagan write in {% cite Moore2022 %} and {% cite Moore2022a %} about the importance of changing the how you build and deploy.
To sum it up, it is essential to establish a fast and incremental/iterative software delivery approach to be successful in developing software products.
The famous [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298) can help you to direct your efforts into the right direction.
This article is about my lessons learned to implement a proper CD, using up-to-date DevOps practices, and implementing the Four Key Metrics to get to development excellence.

## Introduction

> Disclaimer: This article presents my personal opinions and perspectives on the project, so this is not my company's opinion.

When I started as an engineering manager at a former employer in 2018, the team which I joined have run deployments of its software product every two weeks after the sprint has ended.
Major issue, however, was that the deployment took regularly two engineers a full day of work.
The entire deployment process was error-prone, a huge overhead, and repetitive.
Essentially, no engineer really wanted to do the job that was assigned by lot.
Although I experienced lengthy or difficult deployment processes in my career before and also in later career steps, that process was really a nightmare and needed to be changed.

Since then, I am a huge fan of the practices described in the book "Accelerate" by Nicole Forsgren {% cite Forsgren2018 %} and the entire [DevOps Research & Assessment (DORA)](https://www.devops-research.com) program and its outcome, the [State of DevOps Reports](https://www.devops-research.com/research.html#reports).
Simply, a deployment has to be the most natural thing in the world for the developers.
New features should be shipped via fully automated processes in nearly no time to production, so that there is no overhead and can be done with every feature that has been finished or bug that has been fixed.
Nowadays, also the term "developer experience" is connected to that goal (see also: {% cite Tiedemann2021 %}).
As developers and their "experience" are essential to build your product, they should be able to do their work as effectively as possible, otherwise you are loosing money (see: {% cite Moore2022a %}, {% cite Tiedemann2021 %}, and {% cite Forsgren2018 %}).

According to the latest State of DevOps Report 2021, "[...] excellence in software delivery and operational performance drives organizational performance in technology transformations." {% cite Smith2021 %}
While previous reports have only seen a relationship that companies with a good organizational performance have had a good performance in software delivery, it now seems to become clear that also companies concentrating on improving their CD and software delivery performance (SDP) can also improve their organizational performance (see, e.g.: {% cite Forsgren2019 %} vs. {% cite Smith2021 %}).
The State of DevOps Report 2019 summarizes that their "[...] research continues to show that the industry-standard Four Key Metrics of software development and delivery drive organizational performance in technology transformations [...] [It] revalidates previous findings that it is possible to optimize for stability without sacrificing speed." {% cite Forsgren2019 %}

So, with the start of the product development at my current employer in August/October 2021 (see also: [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %})), we directly focused on a proper CD and, thus, SDP.
Recently, we started to measure parts of the [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298), the Change Lead Time and Deployment Frequency (see also: [this section](#four-key-metrics)).

The remainder of this article concentrates on showing you how we did this and what lessons I have learned.
Additionally, I will try to give you insights on the positive effects of all those efforts.
[In the next section](#technical-basis), we will look at the general technical setup that we have.

## Technical Basis

The technical basis of our CD setup is that we mostly follow the [Trunk-based Development](https://cloud.google.com/architecture/devops/devops-tech-trunk-based-development) approach with [Git](https://en.wikipedia.org/wiki/Git).
Trunk-based Development bases on using feature branches as well as working in small batches that are merged as soon as and as often as possible.
The State of DevOps Report 2021 sees Trunk-based Development as one of the core capabilities that drives a higher SDP and organizational performance {% cite Smith2021 %}.

When an engineer in my team starts developing a new feature or a bugfix, she starts a new branch (feature branch) from the main branch.
As soon as the development is done, she creates a Pull Requests (PR) to the main branch.
Immediately, there are different tests running automatically against the branch/PR.
There are unit tests, integration tests, and end-2-end (e2e) tests.
Only if those tests are passed, the merge to main is possible.

Besides the automated tests, the engineers review each other's code in the PR.
As it is often very helpful to really see and click the new features or bugfixes from a testing as well as User Experience (UX) and User Interface (UI) perspective, we implemented so-called PR Deployments (see, e.g.: {% cite Thiel2021 %}).
In a PR deployment, the branch of the PR is deployed to our development environment and can be accessed temporarily via a URL such as `<PR_NUMBER>.pr.example.com`.
The PR Deployments can also be used to run integration and e2e tests with the new code.

When the branch/PR is merged to the main branch eventually, the new version of application is built, deployed to the main development environment, tested with all the automated tests again, and, if they are fine, deployed to our test (a.k.a. stage) environment.
In the test environment the new version of the application can be tested manually and, after approval, deployed to production.

With the described setup that bases on [GitHub](https://github.com/) and [GitHub Actions](https://github.com/features/actions), the pure deployment of a new feature or bugfix after a branch/PR is merged takes roughly five to ten minutes.
Furthermore, we are able to keep track of every version of the application that has been deployed.
We can also roll back to each version of the application nearly anytime.
All in all, I think it is a good—not always perfect—setup.

## Four Key Metrics

The CD setup described in the [previous section](#technical-basis) was a good start to improve the SDP.
After first successes in the first months, there was, however, no more improvement in getting faster or deploying more often.
Maybe, the team did not see the importance to improve the SDP further.
Sometimes it was also just not finishing a PR as soon as possible but prioritizing new features in new branches or not deploying new versions to production although being ready in the deployment pipeline.

In the sense of "you cannot optimize what you do not measure", we, then, decided to measure the SDP and visualize via the [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298) to have a visual feedback of the SDP, guide and challenge the team, and compare our SDP to other companies.
The Four Key Metrics are {% cite Smith2021 %}:
 * Change Lead Time is the time it takes to go from the first code committed to the this code running in production.
 * Deployment Frequency is about how often your team deploys code to production or releases it to end users.
 * Mean Time to Restore (MTTR) is about how long it generally takes to restore the primary application or service when there is an incident or defect that impacts users (e.g., service impairment or unplanned outage).
 * Change Fail Percentage is the percentage of deployments or releases that result in a degraded service (e.g., lead to a service impairment or outage) and subsequently require remediation (e.g., hotfix, rollback, patch, etc)

These Four Key Metrics show a clear link to a high SDP {% cite Smith2021 %}.
They provide a good leading indicator for how the SDP in the organization is doing.
The DORA team also created a [Four Key Metrics Quickcheck](https://www.devops-research.com/quickcheck.html) to self-assess the own SDP and benchmark it to the industry average.

![Four Key Metrics Dashboard in our Office](/assets/four-key-metrics-dashboard.jpg)

Our first analyses via the Four Key Metrics Quickcheck showed that we were doing quite well compared to our industry.
In order to constantly compare, challenge, and guide the team towards a good SDP, we decided to build a dashboard showing the metrics to everybody in the Office on a big screen (see: figure above).
Since we have started to measure the Four Key Metrics—as mentioned before (see: [this section](#introduction)), we concentrated on measuring the Change Lead Time and Deployment Frequency automatically—we have been able to improve the metrics.
For example, the Change Lead Time of our most important project, `autoservice-frontend`, improved from above 1 week to 3.31 days over the last 30 days.
The Deployment Frequency raised from "1 time a day - 1 time a week" to "multiple Deployments per day" over the last 30 days.
For other projects, the metrics also look well—it is important to say that some projects shown on the dashboard are updated less frequently and may, thus, have a higher Change Lead Time and lower Deployment Frequency.

For further improvement, we will probably do some other improvements.
For instance, we figured out that our Definition of Done (see also: [Scrum](https://en.wikipedia.org/wiki/Scrum_(software_development))) should be changed so a feature or bugfix has to be deployed to production before the task in our Scrum Board can be marked as done.
Additionally, there are a lot of small other improvements to be done.

## Lessons Learned

I—and, I think I am speaking in the name of the entire engineering team—can definitely recommend to measure the SDP based on the Four Key Metrics.
A good CD strenthens the developer experience when they are able to push their changes to production easily.
The Four Key Metrics help you to lead your efforts into the right direction (see also: [this section](#four-key-metrics)), and a good SDP is important for an effective and efficient software product development (see also: [this section](#introduction)).
As described in the [previous section](#four-key-metrics), we still need to find a good way to measure and use the quality metrics, MTTR and Change Fail Percentage, of the Four Key Metrics for our purposes.
Furthermore, there is a new metric, Reliability, mentioned in the State of DevOps Report 2021 that we want measure (see: {% cite Smith2021 %}).

For me personally, this is the third time I am leading a cross-functional engineering team following the practices of "Accelerate" {% cite Forsgren2018 %} towards a better CD and SDP.
I can draw a positive conclusion for all three times: Everytime there was a positive result in the SDP.
This time the team, additionally, started to measure the Four Key Metrics to steer the SDP improvements.
It really helped us to visualize the SDP (see also: [this section](#four-key-metrics)).

While implementing the book's measures, there were also team members challenging measures or even the entire effort.
For example, I have always had a lot of discussions while introducing and insisting on Trunk-based Development.
Oftentimes, the teams wanted to run other strategies such as [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) or other non-trunk-based development styles.
Especially, when there was a Quality Assurance (QA) team involved, the wish to practice Trunk-based Development was oftentimes very hard or even not achievable due to QA wanting to check every change before a deployment.

Also, the current team struggled with Trunk-based Development in the beginning.
When we have started, discussions about Gitflow have come up to avoid shipping broken features to production.
It was hard to convince the team to rather improve the testing capabilities such as unit, integration, and e2e tests instead of adapting the way we work with Git.
As mentioned, it is essential to work with Trunk-based Development (see also: [this section](#technical-basis)).

Furthermore, there is always the challenge to communicate the benefits of CD and all the efforts to improve the SDP to your non-tech stakeholders.
Although, this challenge is always existing for techies, this specific challenge can be really hard.
I can definitely recommend to really read the book Accelerate {% cite Forsgren2018 %} and the State of DevOps Reports as well as use the numbers and examples to convince your stakeholders.

Last but not least, there is the challenge to implement the measurement of the Four Key Metrics.
Even though there are different projects available such as [this project](https://github.com/GoogleCloudPlatform/fourkeys), [this project](https://github.com/thoughtworks/metrik), or [this SaaS product](https://www.usehaystack.io/haystack/accelerate-four-key-metrics), we built our own small application to fit perfectly into our environment.
In that own application, we utilize our [technical basis](#technical-basis) such as the GitHub API and Grafana for presenting the Four Key Metrics dashboard as well as the rest of our runtime environment.
Please do a good research what approach fits your requirements.

I hope that this article conviced you to invest into your CD, to use up-to-date DevOps practices, to improve your SDP, and to measure that with the Four Key Metrics.
All in all, I think it is worth the effort—we are on the way towards development excellence.

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autoservice](https://www.huk-autoservice.de) as well as [foobar Agency GmbH](https://foobar.agency) for the awesome work.
Specifically, I would like to thank Dario Segger for the tremendous work on measuring the [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298) as well as building the depicted dashboard.