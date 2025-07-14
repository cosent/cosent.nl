---
title: "GuruScan knowledge management in Plone"
description: ""
date: 2013-03-04
author: guidostevens
---

{{< intro >}}
Cosent integrates the GuruScan expert locator application into a Plone intranet.
{{< /intro >}}

[GuruScan](http://www.guruscan.nl) is a knowledge management application that enables your employees
to quickly locate collegues that have specific expertise.

Unlike other applications that rely on self-certification, GuruScan
crowdsources expertise profiles by asking each employee who their
"go-to person" is for a specific area of expertise.

[Plone](http://www.plone.com) is an open source enterprise content management system
suitable for building large intranets.

Cosent has created a Plone addon, [cosent.guruscan](http://github.com/cosent/cosent.guruscan),
that provides single-signon integration
of the GuruScan webservice into a Plone installation. You need
to obtain a GuruScan client id for this to work.

![GuruScan integration screenshot](/img/guruscan.png)

After installation, cosent.guruscan adds a global tab 'Knowledge Center'
that integrates the GuruScan expert locator service. Users only have to log into their
Plone account; they're then automatically logged into GuruScan as well.

For site administrators, a special view is available
that exports the Plone user database in a format suitable for import
by GuruScan.

Please [contact us](/contact/l) to learn more about locating internal experts,
using GuruScan for Plone.
