---
layout: post
date:   2022-09-16 14:01:20 +0100
title: "With Four Key Metrics to Development and Operational Excellence"
categories:
  - DevOps
  - KPI
  - Development
  - Culture
published: true
hero_image: "/assets/hero-four_key_metrics.svg"
---
In a nice article about why technology matters more and more for companies, Gary O'Brien and Mike Mason mention Continous Delivery (CD) and applied DevOps practices as one of five key factors for a company's success {% cite OBrien2020 %}.
Also Jon Moore and Marty Cagan speak in {% cite Moore2022 %} and {% cite Moore2022a %} about the importance of changing the how you build and deploy.
It is essential to be able to shift from a slow and lengthy release cycles to a fast and incremental/iterative approach to be successful in developing a software product.
This articles is about my experience with CI/CD and the DevOps practices as well as how my current team uses the famous [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298) to get to an excellent development environment which allows us to deploy to production regularly within about five to ten minutes.

## Introduction

> Disclaimer: This article presents my personal opinions and perspectives on the project, so this is not my company's opinion.

When I started as an engineering manager at a former employer in 2018, the team which I joined ran deployments of its software product every two weeks after the sprint ended.
Major issue, however, was that the deployment took regularly two engineers a full day of work.
The entire deployment process was error-prone, a huge overhead, and enormously repetitive.
Essentially, no engineer really wanted to do the job that was assigned by lot.
Although I experienced lengthy or difficult deployment processes in my career before and also in later career steps, that process was really a nightmare and needed to be changed.

Since that point, I am a huge fan of the practices proclaimed by the book Accelerate by Nicole Forsgren {% cite Forsgren2018 %} and the entire [DevOps Research & Assessment (DORA)](https://www.devops-research.com) program and its outcome, the [State of DevOps report](https://www.devops-research.com/research.html#reports).
Simply, a deployment has to be the most natural thing in the world for the developers.
New features should be shipped via fully automated processes in nearly no time to production, so that there is no overhead and can be done with every feature that has been finished or bug that has been fixed.
Nowadays, also the term "developer experience" is connected to that goal (see also: {% cite Tiedemann2021 %}).
As developers and their "experience" are the essential to build your product, they should be able to do their work as effectively as possible, otherwise you are loosing money essentially (see:  {% cite Moore2022a %}, {% cite Tiedemann2021 %}, and {% cite Forsgren2018 %}).

According to the latest [State of DevOps report 2021](https://cloud.google.com/devops/state-of-devops) {% cite Smith2021 %}, "[...] excellence in software delivery and operational performance drives organizational performance in technology transformations." {% cite Smith2021 %}
While previous reports have only seen a relationship that companies with a good organizational performance have had a good performance in software delivery, it now seems to become clearer that also companies concentrating on improving their CD and software delivery performance (SDP) can also improve their organizational performance (see, e.g.: {% cite Forsgren2019 %} vs. {% cite Smith2021 %}).
The [State of DevOps report 2019](https://cloud.google.com/devops/state-of-devops) summarizes that
their "[...] research continues to show that the industry-standard Four Key Metrics of software development and delivery drive organizational performance in technology transformations [...] [It] revalidates previous findings that it is possible to optimize for stability without sacrificing speed." {% cite Forsgren2019 %}

So, with the start of the development of the product at my current employer in August/October 2021 (see also: [this article]({% post_url 2022-05-10-building-an-event-driven-microservice-application %})), we directly focused on a proper CD and SDP.
Recently, we also started to measure the first metrics of the [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298), the Change Lead Time and Deployment Frequency.

The remainder of this article concentrates on showing you how we did this.
Additionally, I will try to give you insights on the positive effects of all those efforts.
[In the next section](#technical-basis), we will look at the general technical setup that we have.

## Technical Basis

The basis of our entire technical setup is that we mostly follow [Trunk-based Development](https://cloud.google.com/architecture/devops/devops-tech-trunk-based-development) with [Git](https://en.wikipedia.org/wiki/Git).
Trunk-based Development bases on using feature branches as well as working in small batches that are merged as soon as and as often as possible.
The [State of DevOps report 2021](https://cloud.google.com/devops/state-of-devops) counts Trunk-based Development as one of the core capabilities that drives higher SDP and organizational performance {% cite Smith2021 %}.

When an engineer starts developing a new feature or a bugfix, the engineer starts a new branch (feature branch) from the main branch.
As soon as the development is done, the engineer creates a Pull Requests (PR) to main branch.
Immediately, there are different tests running automatically against the code of the branch.
There are unit tests, integration tests, and end-2-end (e2e) tests.
Only if those tests are fine, the merge to main is possible.

Besides the automated tests, the engineers review each other's code in the PR.
As it is often very helpful to really see and click the new features or bugfixes from a testing as well as User Experience (UX) and User Interface (UI) perspective, we realized so-called PR Deployments (see, e.g.: {% cite Thiel2021 %}).
In a PR deployment, the branch of the PR is deployed to our development environment and can be accessed temporarily via a URL such as `<PR_NUMBER>.pr.example.com`.
These PR Deployments can also be used to run integration and e2e tests with new code.

When the PR and branch is merged to main branch eventually, the new version of application from the new main branch is built, deployed to the main development environment, tested with all the automated tests again, and, if they are fine, deployed to our test/stage environment.
There the version of the application can be tested manually and, after approval, deployed to production.

With the described setup that bases on [GitHub](https://github.com/) and [GitHub Actions](https://github.com/features/actions), the pure deployment of a new feature or bugfix after a PR is merged takes roughly five to ten minutes.
Furthermore, we are able to keep track of every version of the application that has been deployed.
We can also roll back to each version of the application nearly anytime.
All in all, I think it is a good—not always perfect—setup.

## Four Key Metrics

The described setup (see: [previous section](#technical-basis)) was a good basis to take off towards a improving the SDP.
After first successes in the first months, there was, however, no more improvement.
The team seemed to not see or want to take further steps to improve the SDP.
They mostly lost focus on behavioral and organizational details such as not finishing PR as soon as possible but prioritizing new features in new branches or not deploying new versions being ready in the deployment pipeline to production.
Essentially, there was no Key Performance Indicator (KPI) and visual feedback of the SDP to guide and challenge the team as well as compare our SDP to other companies.

In the sense of "you cannot optimize what you do not measure", we then decided to measure and visualize the [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298).
The Four Key Metrics are {% cite Smith2021 %}:
 * Change Lead Time is the time it takes to go from the first code committed to the this code running in production.
 * Deployment Frequency is about how often your team deploys code to production or releases it to end users.
 * Mean Time to Restore (MTTR) is about how long it generally takes to restore the primary application or service when there is an incident or defect that impacts users (e.g., service impairment or unplanned outage).
 * Change Fail Percentage is the percentage of deployments or releases that result in a degraded service (e.g., lead to a service impairment or outage) and subsequently require remediation (e.g., hotfix, rollback, patch, etc)

Those Four Key Metrics show a clear link to high SDP {% cite Smith2021 %}.
They, moreover, provide a good leading indicator for how the SDP in the organization is doing.
The DORA team also created a [Four Key Metrics Quickcheck](https://www.devops-research.com/quickcheck.html) to self-assess the own SDP and benchmark it to the industry average.
For our team, we decided to build a dashboard showing the metrics and present it to everybody in the Office (see: figure below).

TODO Figure

Since we started to measure the Four Key Metrics—so far, we concentrated on measuring the Change Lead Time and Deployment Frequency automatically—we were able to improve the numbers.
Our first analyses via the [Four Key Metrics Quickcheck](https://www.devops-research.com/quickcheck.html) showed us that we were good compared to our industry, but we have been able to improve the Change Lead Time by multiple days to TODO in average as well as the Deployment Frequency to "multiple Deployments per day" in our core repositories.
The effort confirmed us in our initial good feeling about our benchmark and improved the SDP even more in the last months.

In the [next section](#lessons-learned), we give you an overview about some lessons we learned by implementing the basic setup and the measurment of the Four Key Metrics.

## Lessons Learned

While insisting on Trunk-based Development, I always have had a lot of discussions.
Many team members, now and back then in other teams at other employers, rather wanted to follow strategies such as [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) or other non-trunk-based development styles.
Especially, when there was a Quality Assurance (QA) team, the wish to practice Trunk-based Development was oftentimes not achievable due to the QAs wanting to check every change before deployment.

 * Measurement via own App
 * Concrentrating on Change Lead Time and Deployment Freuqency
 * Outlook: MTTR, Change Fail Percentage, and Reliability metrics

Even though there are different existing technical projects to measure the Four Key Metrics with your project such as [this project](https://github.com/GoogleCloudPlatform/fourkeys) to measure the SDP on the Google Cloud Platform, [this project](https://github.com/thoughtworks/metrik) from ThoughtWorks, or [this SaaS product](https://www.usehaystack.io/haystack/accelerate-four-key-metrics) from Haystack, we built our own small application to fit perfectly into our environment: PerforMetric.
In PerforMetric, we utilize our [technical basis](#technical-basis), the [GitHub API](https://docs.github.com/en/rest), and Grafana for presenting the Four Key Metrics dashboard as well as the rest of our runtime environment.

As mentioned, we started with automating the measurement of Change Lead Time and Deployment Freuqency.
We are working on integrating MTTR and Change Fail Percentage into PerforMetric and our measurement approach.
Furthermore, we are thinking about how to show the new DORA metric for Reliability being mentioned in the [State of DevOps report 2021](https://cloud.google.com/devops/state-of-devops) in our dashboards (see also: {% cite Smith2021 %}).
Reliability is the primary metric for operational performance {% cite Smith2021 %}.
It "[...] is the degree to which a team can keep promises and assertions about the software
they operate." {% cite Smith2021 %}


## Conclusion/Outlook

 * 4 Key Metrics leading you into a good direction
 * We still have a way to go with the quality metrics and the new 5th metric reliability {% cite Smith2021 %}
 * We can definitely recommend using the 4 key metrics

## References

{% bibliography --cited %}

## Acknowledgements

Huge thanks go to the entire product and development team of [HUK-Autoservice](https://www.huk-autoservice.de) as well as [foobar Agency GmbH](https://foobar.agency) for the awesome work.
Specifically, I would like to thank Dario Segger for the tremendous work on the measurement of the [Four Key Metrics](https://www.thoughtworks.com/radar/techniques?blipid=1298) as well as building the depicted dashboards.