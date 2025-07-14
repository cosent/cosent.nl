---
title: "Social intranet sprint Berlin"
description: ""
date: 2014-09-15
author: guidostevens
---

{{< intro >}}
A week of intense collaboration in Berlin has significantly accelerated the development of a new Plone-based social intranet platform.
{{< /intro >}}

The Plone social intranet sprint in Berlin at the Humboldt University was attended to by about 16 participants across two tracks, plus a social program in the evenings. Apart from all the hard work we also had a lot of fun. Berlin is a vibrant city and the Ploners who are also Berliners took us to some great restaurants.

### strategy track

The strategy track saw enthousiastic responses to a plan for joint investment by ~10 Plone companies into a new Plone intranet software suite. We'll use the coming weeks to solidify the momentum for this initiative and try and convert positive intentions into hard investment commitments.

A key part of the proposed plan is a design-first process to create a compelling user experience, leveraging Plone5-compatible frontend technologies. Netsight, Cosent and Syslab have already made an exploratory first iteration with this design process, focussed on re-designing the microblogging and social activity stream interactions in [Plonesocial](https://github.com/cosent/plonesocial.suite).

### coding track

In the coding track, we've taken these new frontend designs and implemented them on top of the existing Plonesocial code base. The result is, that we now have a [Patternslib](http://patternslib.com/) based Plonesocial implementation that can be installed and run in a Plone 4 installation. Because Plone5 [Mockup](http://plone.github.io/mockup/dev/) is also Patternslib-based, the work we're doing is forward compatible and will be easily portable to Plone 5.

In addition to implementing the existing Plonesocial features, the sprint also resulted in the integration of plonesocial.messaging (private one-on-one messages) and new "reply" functionality (conversation threading).

The new frontend introduces a host of new features that are not yet provided by the backend and need to be architected and coded: file uploads, URL and file previews, "@mentions", "liking", "favoriting" etc. Also, we're already working on extending the design with a number of subtle but powerful micro-interactions in the form of shortcodes to provide a pluggable linking system.

The current development version of [Plonesocial](https://github.com/cosent/plonesocial.suite) is more advanced than the last released version, but it needs more work before we can make a production-quality release - so come and join us in the next sprint at [Plone Conference 2014](http://2014.ploneconf.org) in Bristol.
