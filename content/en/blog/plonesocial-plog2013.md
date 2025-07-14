---
title: "PloneSocial PLOG2013 Sprint Report"
description: ""
date: 2013-04-06
author: guidostevens
---

{{< intro >}}
Progress made on PloneSocial during the Plone Open Garden 2013.
{{< /intro >}}

Plone Open Garden is a yearly mini-conference where Plone developers
come together in the beautiful ambiance of Sorrento. This year
about 50 people gathered under the palm trees to exchange knowledge
and collaborate on exciting technologies until late in the night.

### Roadmap

The PloneSocial track started with a presentation by Guido Stevens
giving an overview of the PloneSocial project, and presenting
a vision and roadmap for realizing an open source digital workplace.

[Plonesocial roadmap slides on Slideshare](http://www.slideshare.net/GuidoStevens/plonesocial-roadmap "Plonesocial roadmap")

The vision outlined in the presentation above will also be published
as a whitepaper soon. Fill in your email address on the top right
of this page to sign up for the Cosent newsletter and receive a copy
of the Digital Workplace Technology Roadmap as soon as it's available.

### Sprint Progress

Thomas Desvenain and Guido Stevens collaborated on integrating
collective.local.workspace
with PloneSocial.
This will result in secure collaboration and discussion areas
for teams and communities, with per-workspace microblogging
and activitystreams.

Asko Soukka provided support in setting up Robot Framework
testing for PloneSocial. We now have a setup that provides
local browser testing, remote browser testing via Saucelabs,
and fully automated continous integration testing by
integrating Saucelabs with Travis-CI.

The cool part of this setup is, that it automatically generates
demo videos that shows how PloneSocial works from an end-user
perspective. Because the demo video generation is scripted,
it gets automatically updated for all the new features that we're
developing as soon as we do a Github commit.

Asko also has been working on "speech bubble notes" for such videos
to visualize clicks and annotate screen shots with text that explains
what's going on.

### Follow up

As usual, the sprint results in a lot of promising work-in-progress
that requires more time to be finished and released. Some relevant
follow-ups you can expect to be released in the course of 2013:

* Context-aware microblogging for local workspaces
* Reference design for a fully social workspace
* Functional test coverage and demo video for PloneSocial
