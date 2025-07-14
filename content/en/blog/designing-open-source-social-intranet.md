---
title: "Designing an open source social intranet"
description: ""
date: 2014-03-26
author: guidostevens
---

{{< intro >}}
Cosent and Netsight are designing an open source social intranet platform.
{{< /intro >}}

[Netsight](http://netsight.co.uk) have invited Cosent to collaborate on designing
a complete social intranet software suite, to be developed
in collaboration with the open source [Plone](http://plone.org) community.

A "Plone Intranet" summit in the wake of the 2013 Plone conference
listed *user experience*, that is: design, as the single most important challenge
to tackle if we want to strengthen Plone's attractiveness for
the intranet market.

As everybody knows, design is not a problem one solves in a committee.
We're using a hybrid model of [collaboration styles](http://hbr.org/2008/12/which-kind-of-collaboration-is-right-for-you/ar/1) that allows us
to combine the design strengths of a core team with the scaling capabilities
of an open source community.

The plan is to donate the work we've been doing to the Plone community,
so come and join us at the [Plone Open Garden 2014](http://abstract-technology.com/plog-event-plone-italy) in Sorrento to [get involved](https://trello.com/c/1goE2BMv/22-guido-stevens-plone-intranet).

### So, what have we been up to?

Last winter Cosent published the [Digital Workplace Technology Roadmap](http://cosent.nl/roadmap).

Following up on that, we've been analysing the competition, both
in terms of the user experience their platforms offer but also
in the kind of problems they solve, i.e. what markets they're in.
We see significant market potential for a Plone-based solution.

Additionally, we've analysed dozens of cases studies of award-winning intranet
designs and have clustered hundreds of intranet screenshots to understand
common functional areas, or landing pages, in intranets, mapping those against the model
provided by the Digital Workspace Technology Roadmap.

Last week, Netsight and Cosent have been sprinting to turn the insights gained
from all of that into actionable designs, that can be used to guide software development.

We selected three types of landing pages in intranets for deeper investigation.
For each of these pages, we brainstormed specific *functions* that users would want to use
and card-sorted those into *families* of similar functionality.

![Matt and Lewis at the whiteboard](/img/netsight-march-2014.jpg)

We then picked a single landing page to work on and created several *epics* with short
scenarios about a typical sequence of actions a user would execute to obtain a
specific outcome. For example, one of our epics is:

> (Team Member) Wendy receives an email from Peter with a list of questions and data that need to be collated before the next meeting of the project board. She forwards the mail into the intranet, where she flags it as a todo for next week on Project X, tags it as "board meeting", adding a note with some initial ideas and could @marcella maybe share her thoughts on this?

For each *epic*, we created a diagram that sequenced every *function* invoked as part of
the scenario, and then expanded each function step into a full-fledged *user story*. For example,
one of the steps halfway the above epic is the following user story:

> Team Member can mention other Team Members in the note (using '@' syntax).

### Don't shuffle the stack

Fleshing out those user stories was a lot of work, and involved detailed discussions
about our assumptions and choices regarding security architecture and overall strategy.
This was done by part of the team, while the other half worked on wireframing possible
solutions for the epic. That was a bad idea. They had the same discussions, with different
conclusions.

![elements of user experience](/img/elements-of-user-experience-j_j_-garrett.jpg)

Moving from epic to wireframing involves jumping a level up the design stack in
the [Garrett](http://www.amazon.co.uk/gp/product/0321683684/ref=as_li_ss_tl?ie=UTF8&camp=1634&creative=19450&creativeASIN=0321683684&linkCode=as2&tag=cosent-21) five-level model of the design process.
When we brought the finished user stories together with the wireframe sketches we had
some major inconsistencies. This appears to confirm the model and indicate that you
need to get your foundations right before moving to more concrete designs.
In this case, you really need to define your scope in detail, before wireframing solutions.

After re-syncing our minds and merging our work, in the final day we ventured
into wireframing territory not for a whole page, but for exploring a set of micro-interactions
that form the core of a cohesive social intranet experience.
We also deepened our understanding of user needs and elaborated
on the personas we're using to drive the design.

All in all, we feel we have not only made significant progress towards valuable design outcomes,
but also have prototyped a repeatable design process that tackles very complex design challenges in a systematic way.

We plan to have another design sprint in a few weeks to prepare for Sorrento, and look forward to sharing our work there.
See you in lovely Italy!
