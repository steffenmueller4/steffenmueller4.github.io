---
layout: post
date: 2026-06-15 09:00:00 +0100
title: "How Does Leadership Change With AI? — A View From the 2026 Practitioner Evidence"
categories:
  - Leadership
  - Management
  - Culture
published: true
hero_image: "/assets/hero-modulith_trend.svg"
---
In this article, I would like to reason about how leadership and management in software engineering is changing in the age of (Generative) Artificial Intelligence (AI).
For that, let us check what AI is changing with a cross-check from practice.
Next, ...

## What is Changind with AI?

1. Code stops being an asset, becomes a cache.
Once regeneration is near-free, lines of code stop being "treasured, curated" artifacts and start acting like a disposable
  materialized view of understanding — Charity Majors' framing (see [[engineering-discipline-shift]]). The durable artifacts move
  up a level: specs, architecture, tests, evals, observability. The provocative "Deletion Test" — the reasons you can't just
  delete and regenerate an implementation are all evaluation problems, not code problems.

2. Volume explodes, and volume is a warning sign, not a win.
  AI-authored code went 27% → 52% of new code in a single year, and median PR size nearly doubled (44 → 72 lines) (DX data,
  [[ai-code-quality-and-risk]], [[reock-2026-ai-authored-code-doubled]]). More code = more complexity "almost by definition"
  (Breck). The risk cluster: security vulns (~40% more), "tech debt by default" (nobody wrote it, nobody understands it), and the
  accountability vacuum — "nobody reads the code." The concrete cautionary tale: Amazon's 6.3M-order March 2026 outage linked to
  AI code.

3. The bottleneck moves — but not where people think.
  Review burden genuinely grows, but the sharper claim (Google's Collin Green) is that coding was never the long pole — it's ~14%
  of dev time. The real poles are planning, prioritization, decisions, operations. Much of the "review is the new bottleneck"
  pain is perceptual: when writing a PR collapses to 10 minutes, waiting hours for a reviewer feels unbearable even when merge
  times actually dropped ([[code-review-as-bottleneck]]).

4. Productivity gains are real but modest and fragile.
  The gap between felt and measured productivity is large: controlled studies show 55–70%, but longitudinal real-world data shows
  ~8% median PR throughput, and 66% of developers who hit peak time-savings fall back within quarters
  ([[productivity-measurement-paradox]]). "False velocity" — celebrating output growth without asking whether customer features
  actually shipped — is now a named executive-level pathology.

5. Discipline becomes the multiplier, not optional.
  The strongest cross-source convergence in the wiki: AI amplifies good engineering rather than replacing it. Majors:
  nondeterministic systems demand more rigor. Breck via Farley: AI works well only when it has a deterministic feedback signal (a
  passing test) to iterate against autonomously. The keystone investment is unglamorous — a fast, scalable
  build/CI/CD/test/observability loop. Breck's claim: AI stratifies teams — those with tight feedback loops and few handoffs pull
  far ahead; those without stall ([[feedback-infrastructure-as-ai-differentiator]]). Larson's first-person evidence: a deploy
  overhaul took him from ~6 to 200–400 deploys/week, and "slop poisons the loop" — cheap unverified output actively degrades
  subsequent AI work.

6. Operations is the underrated frontier.
  Most discourse is about writing code; Breck argues AI's impact on incident response, log analysis across hundreds of servers,
  and production monitoring is "at least as significant."

## The dominant pattern: AI amplifies, it does not fix

> Disclaimer: This article presents my personal opinions and perspectives on how AI will change leadership and management.
> So, this is not necessary my company's opinion.

Across nearly every source I have read this year, the same observation appears, often in the same words.
A Staff+ engineer in Orosz's survey states it most cleanly: *"AI is an amplifier, not a fixer. Good software engineering practices get multiplied. So do the bad ones"* (Orosz, 2026).
Jesse Adametz of Twilio puts it the same way at DX Annual: *"AI is an amplifier. If you've got high-performing engineers, they weren't putting garbage into the system before and they're still not. Garbage in, garbage out"* (Reock, 2026).
DX's longitudinal data agrees: a 65% rise in AI tool usage produced only an ~8% median PR throughput gain across 400+ companies — but the outliers had something specific in common, namely an "all-in culture" with centralised rollout, leadership advocacy, and infusion of AI across the entire SDLC rather than just coding (Noda, 2026).

The leadership consequence is not subtle.
The first question is no longer "which AI tool do we deploy?" but "what is our current substrate, and what will AI scale up if we deploy it on top of that substrate?".
Strong code review, strong documentation, healthy guardrails, leadership advocacy: AI multiplies these.
Brittle review, weak documentation, an incentive to ship volume: AI multiplies those too.
Where the substrate is weak, deploying AI faster *worsens* the very dynamics the AI was supposed to fix.

## The role shift: orchestrator, not commander — at every level

In the earlier post I argued — following Ergün and Marone — that leaders move from being functional experts who direct and control, to being orchestrators of human-AI collaboration {% cite Erguen2026 %}.
The 2026 literature confirms this strongly and pushes it further in two ways.

First, the orchestration shift now appears as an *individual contributor* skill too, not just a management one.
Sean Goedecke's essay on how he uses LLMs as a staff engineer in 2026 describes a workflow that is essentially orchestration done one developer at a time: he starts every code change by asking an agent, evaluates and rejects five or six attempts before accepting one, narrows the search space for difficult bugs, and pushes back on agent theories that are wrong (Goedecke, 2026).
Eirini Kalliamvakou (GitHub) makes the same point at the DX panel: defining intent, setting constraints and guardrails, providing context and verifying output *is* engineering work, *"at a different level of abstraction"* (Reock, 2026).
So "orchestration" is not only a verb for managers; it is becoming the everyday craft at every level.

Second, the same panel surfaces a disagreement that is worth holding on to.
Houck notes that orchestration *"is a different skillset we're not hiring for yet"* — prior management experience (delegation, context switching) makes engineers more effective with agent-heavy workflows, but the hiring pipeline still optimises for individual technical contribution.
Adametz pushes back that not everyone wants to be a manager.
Both can be true at once: orchestration may be a competence in growing demand without being uniformly distributable across the workforce.
For technical leaders, this is the practical pipeline question of the next few years.

## The same org chart, very different work inside it

One of the most striking findings of the 2026 panels is that none of the large engineering organisations I read about (Microsoft, 1Password, Atlassian) actually redrew their org charts.
What changed instead was how teams *form* and how planning *cadences* are run.
Atlassian now runs zero-to-one projects with squads of three or four, on the grounds that AI compresses the building enough that the bottleneck has moved to alignment and decision-making.
Microsoft has shifted to eight-week mission-specific v-teams whose goal is *speed of learning* rather than sustained delivery.
1Password compressed its planning horizon from 12–18 months down to a single quarter, because *"anything beyond 90 days is guesswork"* (Reock, 2026).

This nuances the "Great Flattening" narrative considerably.
Middle management is not being eliminated; it is being reshaped from coordination work toward orchestration, alignment, and short-cycle decision making — without anyone moving boxes on a slide.
For a technical leader, the cheaper interventions (cycle length, team size, planning horizon, decision rights) clearly do more work than headcount changes do.

## The measurement break — and "false velocity"

A second sharp pattern is that the easy productivity story does not survive the data.
Stray et al.'s NAV IT longitudinal case study (26,317 commits, two years, 39 developers) found no statistically significant change in commit-based activity after Copilot adoption, even though developers consistently *felt* more productive {% cite Stray2026 %}.
DX's 400+ company study reaches a strikingly similar place from a different angle: 65% adoption rise; ~8% median PR throughput gain (Noda, 2026).
And Houck's "Efficiency Plateau" analysis adds a temporal twist: 66% of developers who reach peak self-reported time savings *fall back* to lower bands in subsequent quarters; gains are temporary even with continued use (Houck, 2026).

Abi Noda gives the cultural risk a name: *false velocity*.
Organisations celebrate AI-driven output growth (PRs, commits, lines, token usage) without checking whether the roadmap actually moved.
Uber's CTO went viral after admitting the company had blown through its 2026 AI budget by mid-March — and Uber's president Andrew McDonald said the quiet part out loud: *"the link between [AI productivity gains and shipped features] is not there yet"* (Orosz, 2026 — *The Pulse*).
This is the most important measurement habit the new evidence asks of leaders: insist on a path from AI metrics to *customer-visible outcomes*, and treat that path as the indicator, not the volume of AI-touched work.

## A new responsibility: AI cost as a management discipline

Nothing in the original Ergün literature prepared me for how quickly cost has become a first-class management problem.
Taroon Mandhana (Atlassian CTO of AI & Teamwork) admits to being on his third 2026 budget forecast since January: *"we literally started to think about managing it like AWS COGS cost because it requires that level of rigor and sophistication"* (Reock, 2026).
1Password built an internal tool that maps token spend to repos and projects and negotiates forward-volume commitments with model providers, the way one would negotiate a cloud contract.
DoorDash has given every engineer a monthly token budget; exceeding it requires an efficiency plan.

But there is a counter-position worth taking seriously.
Tim Bozarth (Microsoft) argues that *"not every token needs to produce direct value. Some of this spend is learning and experimentation. The fastest learners will win, and that means we are going to spend tokens on things that do not create value, but they create learning amongst the workforce"* (Reock, 2026).
Leaders need to hold both: cost discipline for production use cases *and* deliberate learning headroom for exploration.
Treating one as the other is a known failure mode in both directions.

## The hardest job: protect the learning organisation against the AI-adoption climate

The synthesis that I find most pressing — and most uncomfortable — comes from Erik Wiffin and is reinforced by Jennifer St Pierre's framing at Dell.
Wiffin's argument runs as follows.
AI adoption demands the conditions Amy Edmondson identified for learning organisations: psychological safety, slack in the system, and a response-to-mistakes orientation that treats *intelligent failures* as the price of doing experimental work (Wiffin, 2026).
But the conditions surrounding AI adoption — urgency, fear, hype, competitive pressure, mandate pressure, the cultural drift toward 996 work schedules — are *the worst possible conditions* for becoming a learning organisation.
Companies demand certainty and treat mistakes as unacceptable at exactly the moment when the work requires the opposite.

St Pierre at Dell reaches the same conclusion from a different angle.
She names five leadership imperatives for AI adoption, and the load-bearing one is *creating psychological safety for experimentation*: *"silence is expensive"* — discouraging candor means decisions get made on filtered information (Noda & St Pierre, 2026).
She is also explicit that *"compliance is not the same as commitment"*.
Organisations that treat AI as a tooling rollout achieve adoption metrics but struggle to build the trust and engagement that lasting change requires.

For me, this is the leader's *actual* hardest job in 2026.
The macro environment is pushing in one direction; the work demands the opposite.
The leader's task is to counterbalance the climate inside the team: to defend space for intelligent failure when the surrounding noise treats failure as unacceptable, to give people time to internalise what they learn when the broader pressure says "go faster", and to treat the engineers' own paradigm shift as a transition to support rather than a problem to manage.

## The leadership pipeline is breaking now

Marone warned, in 2025, that AI eating entry-level work would over time hollow out the proving grounds where future leaders develop.
The 2026 survey data show this happening in real time.
Orosz reports senior engineers explicitly *not* delegating tasks to juniors any more, because they delegate to AI instead:

> *"AI allows me to have work done that I would usually delegate to a junior or pay a SaaS for."*  
> *"I've begun to automate any repetitive task that we previously relied on juniors and offshore contractors for."*  
> *"I no longer have to delegate work by writing a very long document and briefing a junior engineer."*

A staff engineer in the same survey is blunt: *"Agentic AI is a fascinating mirror. It can code as well as the user who drives it. If that user is a junior engineer, now you have a faster junior engineer. […] What agentic AI doesn't do is magically convert a junior engineer into a staff engineer"* (Orosz, 2026).
At the same time, junior engineers are the *highest* token spenders in many orgs and produce less value per token, because they don't yet have the judgement to direct AI well.
Houck also documents a "competence penalty" in AI-assisted work, where women and older engineers receive harsher evaluations for output that is *identical* to others' (Houck et al., 2026).

The leadership move follows from the diagnosis: *deliberately preserve junior-development tasks* — even when AI could do them faster — because the option-value of the apprenticeship pipeline outweighs the short-term productivity loss.
This will rarely make it into a quarterly KPI.
It is exactly the kind of long-horizon investment that a leader has to make on conviction.

## A contradiction worth naming: practitioner consensus vs. organisational reality

One last pattern is too clear to leave out.
Every elite practitioner panel I read — Microsoft, Atlassian, 1Password, Twilio, Etsy — converges on the same message: *do not mandate AI usage*.
Twilio did light enablement and adoption "took off on its own".
Rafe Colburn at Etsy is sharper: mandates lead to shallow "tokenmaxxing" — adoption to hit metrics — and AI adoption is inevitable, so why mandate something inevitable.
Bozarth at Microsoft says explicitly *"we don't set targets for usage itself. The metrics we actually care about are speed, ease, and quality"* (Reock, 2026).

And yet Orosz's 900-developer survey shows the opposite is happening across much of the industry: top-down mandates to use AI, 50%/80%/100% AI-usage targets, AI productivity gains treated as a baseline rather than a bonus, and AI usage tracked as an individual performance metric — a practice Houck flags as a myth most engineering managers still believe in (Reock, 2026).
That is the gap a leader actually has to navigate: the elite-practitioner consensus on the one hand, the pressure from above to mandate and measure on the other.
The best leaders I read seem to absorb the upward pressure without passing it down: they demonstrate adoption (they themselves use the tools), celebrate concrete wins publicly, fund learning headroom, and refuse to use AI-usage as a personal performance metric.

## What I now think leadership is actually for, in 2026

Pulling the threads together: AI does not eliminate management, and it does not just "shift" it.
It changes what management is *for*.

Three responsibilities seem to me to be load-bearing now:

1. **Tend the substrate.** Documentation, code and process quality, review depth, incentive alignment, psychological safety, slack for learning. AI will scale whatever is there. The leader's lever is the substrate, not the tool.
2. **Direct, don't control.** Set goals, guardrails and context; let humans and agents execute; verify outcomes; resist the urge to manage by activity metric. This is the orchestration shift — and it now applies at every level of the org, not only above the line manager.
3. **Counterbalance the climate.** The macro environment pushes urgency, fear, and mandate. The work demands the opposite. The leader's job is to preserve — *inside the team* — the exact conditions (experimentation, intelligent failure, junior development, time to reflect) that the climate erodes.

If there is a single defensible thesis I am ready to commit to, it is this: **AI is the first technology where most of the leadership job is to protect the conditions for collective learning, because the technology itself does not reward — and may actively penalise — the organisations that do not.**

The earlier post argued that leadership had become orchestration of human-AI collaboration.
I still believe that.
But the 2026 evidence has made me think that the orchestration work is downstream of something more fundamental: deciding what kind of organisation you actually want AI to amplify, and then having the discipline to build *that* before you deploy at scale.

## References

{% bibliography --cited %}
