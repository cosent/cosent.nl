---
title: "Agile Design With Paper Prototyping"
description: ""
date: 2011-08-11
author: guidostevens
---

{{< intro >}}
Paper prototyping enables evidence-based interaction designs, and is a natural fit for agile design and development processes.
{{< /intro >}}

A key takeaway of agile software development processes, is the emphasis on *testing*.
Untested software is broken software. More positively: test-driven development
is a joyful practice that produces high-quality code.

Wouldn't it be nice if we could apply this approach to visual and interaction designs as well?
Yes it would, and yes we can.

Paper prototyping is a lightweight method for testing human-computer interaction designs.

### Paper Prototyping Protocol

You prepare a session, by creating simple wire frame drawings of the various screens a user will encounter during the interaction.

The session protocol is as follows:

* A facilitator welcomes the test user, explains the paper prototyping procedure, and gives the user a task she should perform in the application, for example finding a reference document in a web site. The facilitator asks the user to "think out loud" while performing the task.
* The role of the computer is played by a member of the design team. The computer "displays" a screen by putting the right wire frame drawing in front of the test user (see illustration). The computer does not speak, and this is very important.
* The user interacts with the paper prototype by using a pencil. Pointing and tapping the pencil is the same as clicking a mouse. Using the pencil to write text into input fields is the equivalent of using the keyboard.
* The computer responds to the user's input by pasting scroll-down menus onto the wire frame, or "refreshing" the screen by replacing the displayed wire frame.

The user then interacts with the new wire frame display, the computer responds, and the interaction continues until either the task is performed or the user gives up.

This is a simple protocol, but to employ it successfully it's essential to stick to one crucial rule: no conversation. The user should "think out loud" but not pose any questions, and the computer performs his role silently. This constraint forces all interaction to take place as either simulated mouse/keyboard inputs or simulated screen refresh outputs. Not enforcing this constraint quickly degrades the validity of the outcomes of a testing session, and will also make it impossible to compare different test users performing the same task.

You can either videotape sessions, or have an observer take notes. You can easily see where a test user stumbled or made a wrong choice; the "thinking out loud" of the user at that point will provide you with valuable insights on users' thought processes and will enable you to come up with design improvements that remove the bottlenecks.

### Agile Design in Practice

Selecting the right test users is important. They should be as close as possible to the actual target user demographic. You should be especially wary of test users that possess 'insider knowledge' skewing the test results. That said, any testing is better than no testing. Even testing with a handful of insider users will provide valuable insights that enable you to improve the design.

We've employed paper prototyping successfully to evaluate complex web designs. The test sessions identified some areas of confusion, which could be improved by for example providing more visual separation between similar elements.

More importantly, the paper prototyping provided hard evidence we could use in the "battle of the home page". In a big organization, everybody wants their pet project to have a prominent deep link on the home page. The paper prototyping outcomes clearly demonstrated that this would result in a overly complex home page, very confusing to users. Proving that the über-portal design variant was not a valid option, opened up the way for a different and much more elegant approach to designing the home page.

The value of paper prototyping results from two interrelated characteristics: it's cheap to do, and you can do it early in a project. You don't have to wait until a complete high-fidelity design is finished, before testing your design. By pulling the design testing forward, you can avoid mistakes down the line. The earlier you correct course, the cheaper it is to do so.

Producing basic wire frames is relatively cheap and allows you to de-risk major assumptions by testing them in a simulated deployment situation. You can then incorporate the outcomes in the high-fidelity design phase, and run another paper prototyping test session on the high-fidelity designs before committing to the actual software implementation, which is both the most expensive phase in itself, and also the stage where making changes to the design becomes very costly.

Eliciting end user feedback early in the design cycle allows you to test assumptions, remove errors, incorporate improvement suggestions, and prioritize the feature set. Paper prototyping provides an evidence-based process to minimize redesign costs and maximize the quality of human-computer interaction designs.
