---
title: "Plone Software Ecology"
description: ""
date: 2010-08-12
author: guidostevens
---

{{< intro >}}
A social network analysis of the commit histories in the Zope and Plone software repositories.
{{< /intro >}}

Cosent collaborated with the Nottingham University Business School, to analyze the interaction between social network connections and technical structures in the development history of the open source Plone Content Management System.

> Kuk, G. & Stevens, G.. (2010). Corporatizing open source software innovation in the plone community. 16th Americas Conference on Information Systems 2010, AMCIS 2010. 4. 2688-2698. 

{{< button link="/pdf/corporatizing-open-source-software-innovation-in-the-Plone-community.pdf" text="Download paper (PDF)" >}}

### Code Ecology

The Plone system comprises about one million lines of source code
including the Zope application server, on which Plone is built.
Understanding and managing a system of such magnitude requires a
divide-and-conquer approach. The organizing pattern utilizes a generic
framework calling specialized plugin components. Control resides with
the framework, which determines execution flow, not with the plugin.

A Plone website is created by crafting an interrelated set of custom
plugins that modulate visual appearance, define information schemata,
and control policy behaviors to adapt the generic system to
client-specific requirements. Integrators doing Plone customizations can
draw upon an extensive library of plugin components providing
specialized functionality which is not included in the core Plone
framework “out-of-the-box”. Such generic components are created by other
integrators, who encountered similar requirements and published their
solutions to be re-used.

Underlying the custom and generic plugins, is the Plone core system,
consisting of central infrastructure components augmented by dozens of
specialized aspect providers. Plone itself plugs into the Zope
framework, which also can be deconstructed as a set of core
infrastructures augmented by specialized components. The whole of this
component architecture is configured and integrated to act as a single,
integrated system.

### Corporate Ecology

The fall 2009 Plone conference saw an attendance of circa 400 Plone
developers. A typical Plone developer is employed as such by an IT
services company providing integration and customization services to
customers. As of January 2010, the [central directory of Plone integration providers](http://plone.net/)
listed 328 “Plone providers” in 60 countries worldwide. Plone
developers are generally IT professionals, often formally trained in
computer science, who are paid to work with Plone (for customers), and
for whom working on Plone (for the community) is a normal application of
their skills. Several well-established Plone integration providers
subscribe to an informal policy of donating 10% of employee time to the
Plone community in the form of open source software contributions.

The Plone CMS provides a bundle of features that is on par with
commercially developed competitors. Plone can be downloaded for free,
and provides prospective client organizations with a compelling value
proposition: it offers both a feature-rich CMS environment “out of the
box” as well as excellent customization options. The availability of a
mature market of Plone integration providers, in combination with the
open source aspect, is an important consideration for many organizations
that want to minimize the risk of lock-in to a specific technology
provider.

### Technical / Social Network Analysis

Presented at the [2010 Americas Conference on Information
Systems](http://www.amcis2010.org/), our paper builds on a detailed analysis of the full
software development history of [Plone CMS](http://plone.org/) and it's components, most notably
the [Zope](http://zope2.zope.org/)
application server which is bundled with Plone.

From 1997 onwards, we reconstructed technical dependency relationship
networks between the various Zope/Plone code components on a
month-by-month basis. In parallel, we derived social network structures
from authorship networks.

Our results show, that in the beginning years social connection networks
have greater explanatory power for predicting the evolution of the
technical structures, than the other way around. From 2004 onwards,
technical structures were dominant.

### Conclusion

Current Plone CMS development prioritizes technical requirements
and "best solutions" over social/political mechanisms. Not social
cliques but engineering concerns shape the large-scale development
effort. Plone developers
already know this, of course, but our analysis of the complete commit
histories confirms this intuition.

