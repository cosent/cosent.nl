---
title: "Is social networking ready for disruption?"
description: ""
date: 2012-10-03
author: guidostevens
---

{{< intro >}}
Twitter API changes have highlighted a fundamental power asymmetry between social networking services and their users. What can we do?
{{< /intro >}}

The Twitter [API closure](https://dev.twitter.com/blog/changes-coming-to-twitter-api) that was announced last month is a bad thing: it restricts innovation and seeks to lock in users by reducing their freedoms. Little noticed is the Twitter [branding imposition](https://dev.twitter.com/terms/display-requirements) where you cannot even display your own tweets in your own website under your own branding: it has to be Twitter branded.

Some people [miss the point](http://www.guardian.co.uk/technology/2012/sep/16/why-the-disenchantment-with-twitter) and wonder what the hubbub is about. Profit maximization and such. But Twitter has grown big because it provides a public utility that we, it's users, have invested our trust, our time, our content, our attention and our networks in. Changing the rules now amounts to breaching a social contract.

What's playing out now, is a struggle between [two conflicting visions](http://gigaom.com/2012/09/17/twitters-dilemma-we-own-our-tweets-but-it-still-wants-to-control-them/): Twitter the open network utility, versus Twitter the commercial real-time media company:

> "On the one hand, the company wants us to believe that it has no interest in controlling or asserting ownership over our tweets, because it is interested in free speech and is just a conduit for our content — but on the other hand, it wants to control what happens with our tweets, and even shut down services that we wish to use to display that content, in order to monetize something that we created. How does that help us as users?"

It doesn't. And this creates space for radical, disruptive innovation.

### Should profit maximization trump user experience?

Let me contrast two user experiences: the open Firefox experience and the closed iPad experience.

Firefox is an open platform that supports many useful extensions: I use Pocket to save stuff I want to blog about, Buffer to schedule tweets, Feedly as an RSS reader. All those plugins easily cross-integrate, providing me with a unified social media work flow across multiple services.

The iPad, on the other hand, provides a closed platform where you can install many apps (yes: Pocket, Buffer, Feedly) but those apps are not cross-integrated. If I want to Pocket a tweet from the Twitter client, the best I can do is to flag that tweet as a favorite on Twitter. And then use an Internet service called IFTTT to save that tweet to Pocket.

Here's the rub: the [IFTTT Twitter triggers](http://thenextweb.com/twitter/2012/09/21/why-ifttt-forced-remove-twitter-triggers-red-alert-developers/) got killed because of Twitter's API change. Which kills my work flow on the iPad. What I'm trying to show here, is that combining two closed approaches (iOS + Twitter) frequently *deteriorates* the user experience, because it's in the interest of one or both of the commercial parties involved to limit **your** freedom, in order to maximize **their** profit extraction.

Now some, or lots, of people will argue that this is the natural state of affairs in a capitalist society. I beg to differ, especially when it comes to Internet services. *Especially* in a capitalist society, where destroying value for the sake of rent seeking invites disruption.

### Are walled gardens viable in the long run?

In the big picture, the social networking situation is an anomaly on the Internet. The distributed, federated architecture of the Internet is it's key feature. You don't have a separate Hotmail account to email with Hotmail users only, and then a Gmail account that only reaches Gmail users. You just have one email address that sends and receives email across the world, federating with any email service. If you own a domain, you can even switch to another provider and take your email address with you. The web itself is global, the days of AOL-like walled gardens long left behind. All the core Internet protocols are distributed and open. It's called *Inter* -net for a reason, you know.

Except for social networking. There, we don't have a distributed protocol and are forced to rely on centralized services, with all the [risks that entails](https://twitter.com/ValdisKrebs/status/250464936424271872). Or do we?

> "Until we are willing to create new audiences on different networks our complaints are moot." -- [Twitter and the Bitchwagon](http://decafbad.net/2012/09/22/twitter-and-the-bitchwagon/)

In the wake of the Twitter API change [app.net](https://join.app.net) got crowd funded, but that's just a centralized service with an alternative business model. Their much-hyped alignment of interest between service and users stops the moment you want to stop paying and take your social presence elsewhere.

In an earlier wave of disenchantment with centralized services, [Diaspora](http://diasporaproject.org/) got crowd funded as an alternative to Facebook, and now provides an up-and-running federated social network service using an open source engine.

### Open protocol for social networking

The folks at [tent.io](http://tent.io/) are taking this one step further.

> "Because private messages (and many other important features) are beyond the scope of most federation protocols, users can not send private messages to users of other Social Service Providers."

They're aiming to fix this lack of privacy control, and more. Tent.io is not a federated service, but a **distributed protocol** that allows disparate services to connect and inter-operate. The current draft protocol is pretty neat and offers fine-grained security features, in addition to a rich content model. The software is open source, so you can hack it; and the protocol is documented, so you can write your own software to inter-operate if you want to. To get you started quickly, there's also a hosted service available at [tent.is](https://tent.is/)

It looks like crap, has a big warning flag **ALPHA WARE**, and you can't actually do any social networking because a) there's nobody there and b) even if they were, you wouldn't be able to find them since there's no user discovery mechanism (yet).

In short, it has all the necessary attributes for a disruptive innovation that incumbents feel safe to ignore. The magic ingredient that can make this happen, is the combination of an open protocol, with an open source "minimally viable product" reference implementation. That's how SMTP started, which is email. It's how HTTP/HTML started, which is the Web. It's how TCP/IP started, which is the Internet.

The power of the tent.io proposition is, that it aims to remedy the anomaly where we have distributed open protocols for everything, *except* for social networking. This leverages a huge latent energy by aligning itself with an open paradigm that is literally hard coded into the core of the Internet.

### The power of open is easily underestimated

Open culture has become a powerful [cultural force](http://emergentbydesign.com/2012/09/07/why-the-world-need-hackers-now-the-link-between-open-source-development-cultural-evolution/) that [changes the world](http://philosophyforchange.wordpress.com/2012/09/27/the-family-history-of-facebook-why-social-media-will-change-the-world/).
Open source is both a driver, and the natural expression, of this paradigm.
Open source and open protocols work, because they provide a vendor-neutral, commoditized infrastructure on top of which companies can build their own offerings. A shared, commoditized infrastructure layer lowers costs, lowers barriers to entry, speeds up innovation and scales like hell.

It's easy to dismiss something like Tent.io with the objection, that there's no way for a non-player with no resources to bootstrap a new social networking service and steal a 100million+ people from existing services. But: it's not about playing that game. It's about changing the rules of the game. There's no need for hundreds of millions of users to switch to Tent.io. We merely need a smart infrastructure, an app if you will, that allows inter-network social conversations. Tent.io scales the moment you can reach your existing Facebook or Google+ contacts from a Tent.io environment.

Who knows how this game could play out? If tent.io gains enough traction "under the radar", we might see an inflection point where one of the incumbents decides that it improves their strategic position to support the Tent.io protocol. Google for example. Unlike Facebook and Twitter, Google is not a one-trick-show. Google+ is merely one branch of Google's vast empire. Supporting an open social networking protocol would align with Google's [data liberation front](http://www.dataliberation.org/) effort. It would turn the social game from a competition between walled gardens where Google+ is an underdog, to a commoditized infrastructure which plays to Google's strengths and can be exploited across Google's sprawl of web services.

What do you think? Are we tied into the social services we use, or is there a genuine opportunity to develop countervailing power through an open protocol approach? What will the social networking landscape look like, in five years?
