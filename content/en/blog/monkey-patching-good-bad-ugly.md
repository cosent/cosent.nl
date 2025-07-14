---
title: "Monkey patching: the good, the bad and the ugly"
description: ""
date: 2013-09-02
author: guidostevens
---

{{< intro >}}
Run-time software modification can save your day, and kill your project.
{{< /intro >}}

This is a highly technical article, intended for a technical audience.
You should probably skip it if you're not a software developer.

I just had a bad news conversation with a client:

> "Your website is doomed. It cannot be upgraded.
> It cannot be maintained.
>
> All your content is fatally compromised,
> as if a computer virus had attacked your site.
>
> The only remedy is to make a fresh copy of the software
> and start from scratch with a clean database.
> The hundreds of pages in your site will have to be re-entered manually."

He was not pleased. I was surprised he didn't cancel my contract, right there and then.
Luckily for me, I am not the author of the original website:
this disastrous outcome was not my doing.

The whole affair did lead me to reflect on the question,
whether this could have happened to me, in one of my own projects?
How resilient are my own coding practices against the kind of extreme
outcomes I just witnessed? Hence, this article.

### The Good

As you will have guessed from the title of this article, we're talking about [monkey patching](http://en.wikipedia.org/wiki/Monkey_patch):
the practice of modifying a system's behavior by changing its code base run-time.

The Good is, that as an integrator working with a software framework like Plone,
you do this all the time without even thinking of it as monkey patching.
Registering an adapter with the [Component Architecture](http://www.muthukadan.net/docs/zca.html) is the canonical way
of customizing the system's behavior, and involves getting your code called
*instead* of the code that normally would be called at that interface point.
Customizing a view template is just a light-weight variant of the adapter pattern.
It's perfectly normal and accepted. This is what ZCML is for.
It's expected.

### The Bad

To paraphrase Cruijff: *"every upside has its downside"*.

The Bad is, that there's a thin line between customizing a framework as intended,
and messing around with collateral damage, i.e. monkeying around.

What if the behavior you want to customize is not componentized in a way that makes
it easy to overlay your custom code over its implementation?
Monkey patch to the rescue:

``` python

import some.framework.goodie

def my_monkeypatched_search(context, query):
    # do something smart
    return

original_search = some.framework.goodie.search
some.framework.goodie.search = my_monkeypatched_search

```

And hey presto! Every call to some.framework.goodie.search now gets dispatched
via my\_monkeypatched\_search instead.

There's a price to pay for this, though:

* It becomes very difficult to debug the call flow.
  You just performed a man-in-the-middle attack against all *other* consumers
  of the framework function you monkeyed.
* You introduce a tight coupling between the framework implementation and your monkey patch.
  Meaning that when the framework changes, your monkey patch has to be upgraded in sync.
  That's a nicely hidden, undocumented maintenance problem you just created.
* Other modules may be trying to override the same original framework function.
  Which means you have a race condition with two (or more) parties warring to get their monkey patch in place.

The last issue is the source of the term monkey patch:
you have *guerrilla* patches fighting it out. Guerilla, gorilla, get it? Monkey patches.

To illustrate how thin the line is: the tight coupling maintenance problem also occurs if you do
a simple template override via z3c.jbot. Unless you plan ahead and check
the *unchanged* upstream template into your customization package *first*,
with a commit message specifying the upstream location,
you'll find it very hard in two years time to port your 5-line template change,
which you didn't document and don't remember,
into a 100-line template file with substantial upstream changes.

To further convolute matters we have [collective.monkeypatcher](https://pypi.python.org/pypi/collective.monkeypatcher):

``` xml

<monkey:patch
        description="This works around issue #xyz"
        class="Products.CMFPlone.CatalogTool.CatalogTool"
        original="searchResults"
        replacement=".catalog.patchedSearchResults"
        />

```

This mitigates the problem somewhat by resolving some sequencing issues when activating the patch.
And it dresses up in a greppable, nice ZCML suit with a tie, blurring the line between legitimate businesses
and the mob.

I'm not saying you shouldn't do this: I do it myself. Occasionally.
But you should be aware of the dangers. Which brings us to the last part,
and the reason I'm writing this piece.

### The Ugly

There's a thin line between customization and monkey patching.
And then there's a slippery slope between monkey patching and hacker hell,
greased with good intentions and hacker hero hubris.

The disaster I described in the introduction was the result of an add-on developer
realizing that not only the code base can be monkey patched.
You can monkey patch actual stored objects in the database, too! Yeah!

Please check your medication, if you think that's a neat idea.

These guys not only overrode every field in every content type in the code base.
With a coding style that pokes out your eye with pep8 violations.
They also changed the storage model for every field. On every content object in the database.
With a one-way migration from mainstream sanity to multiple f\*\*\*edup disorder.

In my client's case, the add-on is poorly maintained and blocks a Plone upgrade.
Removing the add-on results in empty fields on all objects, and gibberish in the catalog.
Trying to reverse-engineer and revert the database hacks makes your head explode.

Code base monkey patches you can escape from: by removing the offending code from
your system. Just refactor away all dependencies and remove the stuff from your buildout.

However, anything that changes your database in a meaningful way, without a corresponding
uninstall, risks turning a nice project into a full-fledged nightmare.
After you've launched, and a change request opens up the can of worms.

Which raises some interesting questions, for me and for you:

* How often do I/you write add-ons without providing and testing an uninstall profile?
* How often do I/you install add-ons without auditing for irreversible installer changes?
* How many of my/your projects depend on add-ons we don't fully understand?
  Whose lead developer has, two years later, apparently moved on to greener pastures?

On all these counts, I plead guilty as charged.
I have sinned and will better my ways.

How about you?
