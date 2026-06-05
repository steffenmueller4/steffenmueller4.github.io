---
layout: post
date: 2026-05-15 08:15:10 +0100
title: "How does Leading a Team Change in the Age of AI?"
categories:
  - Leadership
  - Management
  - Culture
published: true
hero_image: "/assets/hero-modulith_trend.svg"
---
Software development is undergoing a massive transformation driven by Artificial Intelligence (AI).
Yesterday, I have been reading a LinkedIn post from Ralf Plattfaut based on their research on how leadership changes in the age of Generative AI (GenAI) at {% cite Erguen2026 %}.
Key findings of the article are 1) leaders need to navigate the technological adoption with clear communication, targeted training, and patience; 2) leaders must account for the interdependencies between humans and GenAI; 3) leaders become more and more orchestrators of human-AI collaboration.
This article summarizes my experiences with the changes on how to lead a development team in the age of AI recently.
My experiences support the findings Erguen et al. found {% cite Erguen2026 %}.

## Introduction

How leadership changes in the age of Generative AI (GenAI) {% cite Erguen2026 %}.

What currently changes: {% cite BloombergTelevision2026 %}

How to integrate AI in organizational settings: {% cite Alkfairy2025 %}

{% cite Nakash2025 %}

{% cite Houck2026 %} and {% cite Butler2026 %}

## The Short-Term Reality: Traditional Challenges

In the early stages of GenAI adoption, organizations face familiar hurdles. These mirror traditional technology adoption challenges: resistance to change, training gaps, and the initial productivity dip as teams learn new workflows. Leaders navigate these waters much as they always have—through clear communication, targeted training, and patience.

Pull-Request perspective from {% cite Newman2026 %}

## The Mid-Term Transformation: A Complete Reboot

Where things get interesting is in the mid-term. The research reveals that as GenAI becomes deeply embedded in daily work, the implications for leadership become far more profound. It's no longer just about managing the introduction of a new tool—it's about fundamentally rethinking what leadership means.

It is worth noting that this shift did not start with GenAI. Empirical work on agile teams already showed that leadership had been moving away from a single role toward a property of the team: dynamically shared among team members, engendering belonging, and balancing competing organisational cultures {% cite Gren2022 %}. GenAI accelerates and deepens this trend rather than starting it.

The most striking finding: **Leadership can no longer be understood solely through human-centered lenses**. Leaders must now account for the interdependencies between humans and GenAI. This isn't a marginal adjustment—it's a complete recalibration of the leadership role.

## From Manager to Orchestrator

The study identifies a critical shift: leaders must evolve from **functional experts** who direct and control, to **orchestrators of human-AI collaboration**. This means:

- **Navigating instead of managing**: Rather than assigning tasks and monitoring completion, leaders guide teams through complex human-AI workflows
- **Ensuring the best fit**: Matching tasks to the right combination of human creativity and AI efficiency
- **Letting go of control**: Trusting AI outputs while maintaining human oversight and judgment
- **Protecting the team learning loop**: An empirical study of GenAI-equipped agile teams found that developers increasingly ask ChatGPT for help instead of asking co-workers, which changes how knowledge spreads through the team {% cite Ulfsnes2024 %}. Leaders need to actively design rituals (pairing, code reviews, brown-bags) that keep peer-to-peer learning alive.

## AI as a Cognitive Partner

The framing that I have found most useful for thinking about this — and the one that pulls many of the threads above together — is **AI as a cognitive partner** rather than AI as a tool or AI as a replacement.

The idea is older than today's GenAI debate. In 1960, J.C.R. Licklider already imagined a near future in which "human brains and computing machines will be coupled together very tightly" so that the resulting partnership would "think as no human brain has ever thought" {% cite Licklider1960 %}. The framing went dormant for decades while AI took a more autonomous direction, but the recent rise of LLMs has revived it under a new name: **Hybrid Intelligence**. Dellermann and colleagues define a Hybrid Intelligence system as one in which humans and AI contribute *complementary* capabilities to achieve goals neither could reach alone — and they argue that the central design question is no longer "what can the AI do on its own?" but "how do we compose human and machine intelligence into a working whole?" {% cite Dellermann2019 %}.

A more recent, deliberately provocative formulation pushes this further: AI is not just a partner outside us, but an actual **cognitive extension** of how we think. Chiriatti et al. propose calling it **"System 0"** — sitting before Kahneman's intuitive System 1 and deliberative System 2, shaping the very information substrate on which our thinking operates {% cite Chiriatti2025 %}. Whether you find the System 0 label compelling or overblown, the underlying observation is hard to deny: many of us no longer start a difficult problem alone; we start it with an AI.

For an engineering manager, the cognitive-partner framing has two practical consequences.

**First, it gives you a vocabulary for choosing where the AI sits in each workflow.** Sherson et al. distinguish four patterns — Human-Out-Of-The-Loop, Human-On-The-Loop, Human-In-The-Loop, and full Hybrid Intelligence — and link each pattern to its own risks: end-user resistance, value-misalignment, employee **deskilling** versus employee **upskilling**, and the need to redesign the business process itself {% cite Sherson2023 %}. The decision "should the AI write this code, or just review it?" stops being an ad-hoc tool choice and becomes an explicit pattern choice with predictable consequences.

**Second, it forces honesty about when partnership actually helps.** A recent synthesis of sixty years of human-AI collaboration research describes a **performance paradox**: human-AI teams tend to show *positive* synergy in content creation and problem formulation, but *negative* synergy in judgement and decision tasks, where the team often does *worse* than the AI alone {% cite Tong2025 %}. Read carefully, this is a strong argument against the reflex to keep humans "in the loop" everywhere. Effective leadership now includes knowing which decisions to delegate fully and which to keep firmly on the human side — and being willing to step back from the ones in between.

The cognitive-partner framing therefore is not just a nicer metaphor than "AI as tool". It changes what a leader actually does day to day: choosing collaboration patterns, protecting the kinds of cognition that humans must keep doing themselves, and resisting the temptation to insert humans where they degrade rather than improve the outcome.

## What This Means for Technical Leaders

As someone leading a development team, I've observed these shifts firsthand. The leader's value increasingly lies not in being the best coder or knowing the most technical details, but in:

1. **Understanding the human-AI dynamic**: Knowing when to leverage AI capabilities and when human insight is irreplaceable
2. **Fostering collaboration**: Creating environments where humans and AI work together seamlessly
3. **Evolving continuously**: Staying current with AI capabilities while developing new leadership competencies

## What the Evidence Says About Productivity

It is tempting to jump straight to the productivity story, but the empirical picture is more nuanced than the headlines suggest. A controlled experiment with GitHub Copilot showed that the treated group completed an HTTP-server task **55.8% faster** than the control group {% cite Peng2023 %}. That number is real, but it describes a narrow task in a narrow language under controlled conditions.

A longitudinal mixed-methods case study at a large public-sector organisation tells a different story: across 26,317 commits from 703 repositories, Copilot users were consistently more active than non-users—but already so *before* adoption. After adoption, no statistically significant change in commit-based activity was observed, even though developers subjectively perceived themselves as more productive {% cite Stray2026 %}. The gap between subjective experience and objective metrics is itself something leaders need to navigate.

Productivity is also not the only dimension. Recent literature flags concerns around the security of AI-generated code and intellectual-property risks that managers need to govern rather than ignore {% cite Nettur2025 %}. And the pipeline of junior developers is changing: educators and industry are rethinking how new engineers learn the craft in a world where the first reflex is to prompt an assistant {% cite Bull2023 %}.

## The Bigger Picture

The research makes clear that this isn't a temporary adjustment—it's a fundamental transformation of leadership in knowledge-intensive environments. Organizations that recognize this shift and help their leaders evolve will be better positioned to harness the full potential of GenAI. The software engineering research community itself anticipates a growing symbiotic partnership between developers and AI in the coming years {% cite Terragni2024 %}.

The question is no longer whether leadership must change, but how quickly we can adapt our mindsets and practices to lead effectively in this new era.

## References

{% bibliography --cited %}
