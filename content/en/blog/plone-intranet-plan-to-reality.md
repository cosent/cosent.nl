---
title: "Plone Intranet: from plan to reality"
description: ""
date: 2015-07-22
author: guidostevens
---

{{< intro >}}
Collaborating with nine companies across five countries, the Plone Intranet Consortium moved from plan to working code within months. How did we do it?
{{< /intro >}}


{{< vimeo id="133651196" >}}

In the fall of 2014 we
[announced](/blog/plone-intranet-consortium)
the formation of the
[Plone Intranet Consortium](http://ploneintranet.com) -
a collaboration between Plone technology companies to develop a Plone based
open source digital workplace platform.

Fast-forward to summer 2015: we've already done a
[Mercury "technology preview" release](https://pypi.python.org/pypi/ploneintranet/0.1)
and are now in feature freeze, preparing for the 1.0 release, codename Venus, this summer.

As you can see in the video, for all of us it's very important to be part of the open source community
that is Plone.

At the same time, we use a different process: design driven, which impacts our code structure
and the way integrators can leverage the Plone Intranet platform.

### Sharing and re-use

All of our code is open source and [available on Github.](https://github.com/ploneintranet/ploneintranet)
In terms of re-use we have a mixed strategy:

First of all it's important to realize we're doing a design-driven
product, not a framework. We have a vision and many components are
closely integrated in the user experience (UX). From a UX perspective, all of Plone
Intranet is an integrated experience. Sure you can customize that but
you have to customize holistically. You cannot rip out a single feature
and expect the UX for that to stand on it's own.

In the backend the situation is completely different. All
the constituent packages are separate even if they live in one repo
and one egg. You can install ploneintranet.microblog without installing
the whole ploneintranet stack: i.e. the whole ploneintranet source needs
to be there (at the python level) but you can load only the
ploneintranet.microblog ZCML and GS and you'll be fine. All our packages
have their own test suites which are run independently. Of course you
need activitystream views to display the microblog - and that's frontend
UX and one of the most complex and integrated parts of our stack, with
AJAX injections, mentions, tagging, content mirroring and file preview
generation.

Another example is search: a completely re-usable backend but you'd
have to provide your own frontend. Our backend is pluggable - we
currently support both ZCatalog and Solr engines and expect to also
support Elastic Search in the future.
We have documented our
[reasons for not reusing collective.solr.](http://docs.ploneintranet.org/development/components/search.html#why-not-collective-solr)

### Design and user experience are key

We don't believe that loosely coupled components with
independent developer-generated frontends create a compelling user
experience. Instead of working from the backend towards the frontend, we
work the other way around and focus on creating a fully integrated,
beautiful user experience.

The downside of that is that it becomes more
difficult to reuse components independently. That's a painful choice
because obviously it reduces open source sharing opportunities.
We do open source for a reason, and
you can see much evidence that we care about that in
[the level of our
documentation](http://docs.ploneintranet.org), in our code quality, and in the careful way we've
maintained independent backend packages, including listing component
package dependencies, providing full browser
layer isolation and most recently providing clean uninstallers for all
our packages.

Plone Intranet is a huge investment, and we're donating all our code
to the Plone community. We hope to establish a strong intranet sub-community
while at the same time strengthening the vibrancy of the Plone community
as a whole.
