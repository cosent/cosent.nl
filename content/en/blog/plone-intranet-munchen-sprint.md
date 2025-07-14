---
title: "Plone Intranet München sprint report"
description: ""
date: 2015-03-14
author: guidostevens
---

{{< intro >}}
Sprinting in München transformed both the team and the code base of Plone Intranet.
{{< /intro >}}

The Plone Intranet project represents a major investment by the companies that together
form the Plone Intranet Consortium. Last week we gathered in München and worked really
hard to push the Mercury milestone we're working on close to an initial release.

Mercury is a complex project, challenging participants out of their comfort zones
in multiple ways:

* Developers from 6 different countries are collaborating remotely,
  across language barriers and time zones.
* People are collaborating not within their "own" home team but across company
  boundaries, with people whom they haven't really collaborated with before,
  and who have not only a different cultural background but also a different
  "company coding culture" background.
* The backend architecture is unlike any stack peope are used to work with.
  Instead of "normal" content types, you're dealing with async and BTrees.
* The frontend architecture represents a paradigm shift as well, requiring
  a significant change in developer attitude and practices. Many developers are
  used to work from the backend forward; we are turning that on it's head.
  The design is leading and the development flow is from frontend to backend.

So we have a fragmented team tackling a highly challenging project.
The main goal we chose for the sprint therefore, was not to only produce code
but more importantly to improve team dynamics and increase development velocity.

Monday we started with getting everybody's development environments updated.
Also, Cornelis provided a walkthrough of how our Patternslib-based frontend
works.
Tuesday the marketing team worked hard on positioning and communications,
while the developer teams focused on finishing open work from the previous sprint.
As planned, we used the opportunity to practice the Scrum process in the full team
to maximize the learning payoff for the way we collaborate.
Wednesday we continued with Scrum-driven development.
Wednesday afternoon, after the day's retrospective,
we had a team-wide disussion resulting in a big decision:
to merge all of our packages into a single repository and egg.

### The big merge

Mercury consists of 20 different source code packages,
each of which had their own version control and their own build/test tooling.
This has some very painful downsides:

* As a developer you need to build 20 separate testing environments.
  That's a lot of infrastructure work, not to mention a fiendishly Jenkins setup.
* When working on a feature, you're either using a different environment than the
  tests are run in, or you're using the test environment but are then unable to
  see the integrated frontend results of your work.
* Most user stories need code changes across multiple packages, resulting in
  multiple pull requests that each depend on the other. Impossible to not break
  your continuous integration testing that way.
* We had no single environment where you could run every test in every package at once.

So we had a fragmented code base which imposed a lot of infrastructure work overhead,
created a lot of confusion and cognitive overhead, actively discouraged adequate testing,
and actively encouraged counterproductive "backend-up" developer practices instead of fostering
a frontend-focused integrative effort.

Of course throwing everything into a big bucket has it's downsides as well, which is why
we discussed this for quite some time before taking our decision.

### Code re-use

The main consideration is code re-use and open source community dynamics.
Everybody loves to have well-defined, loosely coupled packages that they can
mix and match for their own projects. Creating a single "big black box" ploneintranet
product would appear to be a big step backward for code re-use.

However, the reality we're facing is that the idea of loosely coupled components
is not how the code actually behaves. Sure, our backend is loosely coupled.
But the frontend is a single highly integrated layer. We're building an integrated
web application, not a set of standalone plugins.

We've maintained the componentized approach as long as we could, and it has cost us.
A good example is plonesocial: different packages with well-defined loosely coupled
backend storages. But most of our work is in the frontend and requires you to
switch between at least 3 packages to make a single frontend change.

In addition, these packages are not really pluggable anymore in the way Plone devs are used to.
You need the ploneintranet frontend, you need the ploneintranet application,
to be able to deliver on any of it's parts. Keeping something like
plonesocial.activitystream availabe as a separately installable Plone plugin
is actively harmful in that it sets wrong expectations.
It's not independently re-usable as is, so it should not be advertised as such.

We see different strategies Plone integrators can use ploneintranet:

1. Light customization.

   You take the full ploneintranet application and do some cosmetic overrides,
   like changing the logo and colours of the visual skin.
2. Full customization.

   You design and develop a new application. This starts with a new or heavily
   customized frontend prototype, which you then also implement the backend for.
   Technically you either fork and tweak ploneintranet, or you completely build
   your own application from scratch, re-using the ploneintranet parts you want
   to keep in the backend via library mode re-use, see below.
3. Library mode cherry-picking.

   You have a different use case but would like to be able to leverage parts of
   the ploneintranet backend for heavy lifting. Your application has a python
   dependency on those parts of ploneintranet you want to re-use: via ZCML
   and GenericSetup you only load the cherries you want to pick.

Please keep in mind, that this situation is exactly the same for the companies who
are building ploneintranet. We have those same 3 options. In addition there's a
fourth option:

4. Extension.

   Your client needs features which are not currently in ploneintranet but
   are actually generally useful good ideas. You hire the ploneintranet designer
   to design these extensions, and work with the ploneintranet consortium
   to develop the new features into the backend. You donate this whole effort
   to ploneintranet; in return you get reduced maintenance cost and the opportunity
   to re-use the ploneintranet application as a whole without having to do a full
   customization.

You'll have to join the Plone Intranet Consortium in order to pursue this fourth strategy.
But again, there's no difference for current members: we had to join as well.

To make individual component re-use possible, we've maintained the package separation we already had -
ploneintranet may be one repository, one egg, but it contains as separate python packages
the various functional components: workspace, microblog, document preview, etc.
So we do not subscribe to JBOC: Just a Bunch of Code. We don't throw everything into
one big bucket but are actively investing in maintaining sane functional packages.

A variant of cherry-picking is, to factor out generically re-usable functionality
into a standalone collective product. This will generally only be viable for
backend-only, or at least frontend-light functionality, for the reasons discussed above.
A good example is collective.workspace: the ploneintranet.workspace implementation
is not a fork but an extension of collective.workspace. This connection enables us
to implement all ploneintranet specific functionality in ploneintranet.workspace,
but factor all general improvements out to the collective. That has already been
done and resulted in experimental.securityindexing.

### Current status

On Thursday we announced a feature freeze on the whole stack,
worked hard to get all tests to green and then JC performed
the merge of all ploneintranet.\* into the new ploneintranet consolidated repo.
Meanwhile Guido prepared the rename of plonesocial.\* to ploneintranet.\*.
On Friday we merged plonesocial into ploneintranet and spent the
rest of the day in hunting down all test regressions introduced by the merges.
Because we now have a single test runner across all packages that meant
we also identified and had to fix a number of test isolation problems
we hadn't seen before.

Friday 20:45 all tests were finally green on Jenkins!

We still have to update the documentation to reflect the new consolidated situation.

### Results

In terms of team building this sprint has been phenomenal.
We've been sprinting on ploneintranet for five months now, but this was the first
time we were physically co-located and that's really a completely different experience.
We already did a lot of pair programming remotely, but it's better if you are sitting next
to each other and are actually looking at the same screen. Moreover feeling the vibe in
the room is something you cannot replicate remotely. The explosion of energy and
excited talking after we decided to do the consolidation merge was awesome.

On top of that we now have a consolidated build, and I can already feel in my own
development the ease of mind from knowing that the fully integrated development
environment I'm working in is identical to what all my team members are using,
and is what Jenkins is testing. Instead of hunting for branches I can see all
ongoing work across the whole project by simply listing the ploneintranet branches.
Reviewing or rebasing branches is going to be so much more easier.

On top of all that we also made significant progress on difficult features like
the document previewing and complex AJAX injections in the social stream.

We started with a fragmented team, working on a fragmented code base.
We now have a cohesive team, working on a unified code base.
I look forward to demoing Mercury in Sorrento in a few weeks.
