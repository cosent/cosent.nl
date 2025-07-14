---
title: "Agile Change Management"
description: ""
date: 2011-03-11
author: guidostevens
---

{{< intro >}}
A five-step dialog process supports the integration of numerous changes into a consistent, long-term technology strategy.
{{< /intro >}}

Unceasing change appears to be a defining characteristic of our times.
However, it has always been that way: the ancient Greeks said "panta rhei" - everything flows.

Effecting change is surprisingly hard. In the computer technology field, this fact
of life is obscured by a glitzy user interface. The effortless flow of bytes enchants
with a glimpse of Platonic perfection. Everything is possible, or at least should be.
Well, it ain't.

This *expectation* of easy change is one of the toughest obstacles to real change.
The illusion of easy change delegitimizes hard questions about business benefits and
engineering constraints in a complex reality.

Let's focus on this in the context of web technology change management.

### Can we have an extra button please?

What can be easier, for example, than putting an extra button somewhere in a web page?
Clients love to ask for extra buttons, small features here and there, hacks and gadgets.

That might be easy if the *action* that button performs, ties in with what the user
is doing on that page. If it strengthens the user experience, and naturally extends
the software functionality already there, no problem.

On the other hand, the button feature might disturb the overall user experience
and be at odds with deep assumptions in your software stack. In that case,
you're both degrading your brand experience, and picking a fight with a million lines of
upstream software codes. The results: negative benefits, high one-time cost, increased
maintenance costs and decreased flexibility for future changes.

How do you know the difference between a "good" button and a "bad" button?
You don't. Unless you stop talking about buttons, and start talking about
business benefits and engineering constraints.

### Now we're talking business

The simplest way to do that is by embracing the famous "Five W" questions,
extending them into a simple framework:

1. **Why** do we need this (button)?

   How does it create value and contribute to our overall mission?
2. **Who** needs this (button)?

   Who will be delighted by it?
3. **Where** does this (button) belong?

   In what context does it make sense?
   Which capability does it reinforce?
4. **When** does this (button) occur?

   Which process uses it? Which processes does it trigger?
5. **What** does this (button) do?

   How exactly will it work, technically?

You don't need a 3-page countersigned form to do this. Much better is to spend
a few minutes discussing these questions with an inspired team.

Sequence matters. Refocus the discussion on the problem definition first (1: why),
and work downward from that (2, 3, 4) to the optimal solution (5).

This replays the process the initial requester went through, probably mostly subconsciously,
in defining the original button request. Reproducing this process explicitly in a team setting
makes it possible to jointly investigate, and challenge, any hidden assumptions and
abandoned alternatives. This produces better solutions, and improves team coordination.

### Truly Agile

The somewhat paradoxical delight of this approach is, that by refocusing attention away
from implementation issues, to prioritize business value concerns, implementation
becomes much easier. A solid and well-understood business proposition quite naturally leads to an
elegant implementation design, with high long-term values.

Transforming a proposed quick fix into a solution you can be proud of is much harder -
that usually requires reverse engineering (extracting) the implicit business case from the quick fix proposal,
and then discussing alternative solutions in technology terms that conceal the
true business issues at stake. It's easy to get stuck here.

### Getting unstuck

In the context of evolving a web site, we can apply
the "Five W" questions process to itself as follows:

1. **Why** do we need this process?

   To create excellent web experiences at minimal cost and maximal flexibility.
2. **Who** needs this process?

   Any organization that wants to maintain a long-term high-quality web presence.
3. **Where** does this process belong?

   In a small team with business/user representative(s), user interaction designer(s)
   and back-end software engineer(s): reinforcing the web capability.
4. **When** does this process occur?

   After initial request/idea submission, before scheduling implementation design.
5. **What** does this process do?

   Integrate numerous change requests into a value-driven, consistent long-term technology evolution.

### Some questions

Won't this slow us down?
:   Actually: no. Not even in the short term. Doing an ad-hoc fix now may seem fast,
    but it immediately impacts your development speed on other ongoing changes.
    You may have skimped on impact analysis, but the development team will have
    to integrate the impact of this change into the overall picture anyway. Better to bear this
    time cost up-front and generate better solutions with lower long-term disturbance.

We're used to the quick and easy way.
:   You can do better than that.

What do I tell colleagues who want a feature change?
:   "Thank you, we hadn't thought about that yet. We'll investigate this
    issue and prioritize it in our planned change effort. Whom should we contact
    if we have any questions on this?"

We already have a change review process. I hate it.
:   I understand. This is different. We don't need forms and voting. An hour-long (video) meeting
    each week to review all new change requests in context should suffice.

A week? But this is urgent! I need it tomorrow!
:   The only class of issues that warrants such fast turnaround is: critical bugs.
    Feature change requests usually improve when given the chance to mature.
    When everything is urgent, nothing really is. Also note that hasty changes
    quite often have side effects that require new changes in a vicious cycle.
    The "Five W" process is designed to break that cycle and reduce trashing.

How Agile is that?
:   Agile does not mean: anything goes, no structure.
    Agile development uses carefully chosen constraints (time boxed, fixed scope iterations)
    and seemingly counter-productive practices (test driven development, peer programming)
    to actually achieve high speed, high quality results. Software development is
    a highly complex activity. By handling the complexity load upfront, Agile development
    avoids "unexpected" delays and quality problems which are far more costly down the line.

Isn't this difficult?
:   It grows on you with some practicing. And we're in this together and can support
    each other! One of the main benefits of adopting this simple model, is that it
    provides a shared language, facilitating a team effort. It's much more
    fun to collaborate together in creating a kick-ass web experience, than it is to stare
    at the product backlog in isolation.

Did you come up with this by yourself, or what?
:   Yes and no. The text is mine and based on 15+ years of experience managing web technology projects.
    The "Five W" model is adapted from the [Change Ladder](http://www.wizoz.co.uk/Tools/change-ladder.html) model by Mick Cope.
    My thinking on Agile is mainly inspired by [Scrum](http://en.wikipedia.org/wiki/Scrum_%28development%29) and [Test Driven Development](http://en.wikipedia.org/wiki/Test-driven_development).
    If you don't see the problem, take a look into the abyss of [IT Project Failures](http://www.zdnet.com/blog/projectfailures).

Sounds good. We'd like to improve our change process. Can you help us?
:   Sure, please [contact](../contact-info.html) us and we'll work something out.
