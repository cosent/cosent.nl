---
title: "Testing Plone projects with Gitlab-CI"
description: ""
date: 2016-04-11
author: guidostevens
---

{{< intro >}}
How to run continuous integration on private Plone projects, for free.
{{< /intro >}}

Continuous integration testing is a key enabling practice for agile coding projects.
In the Plone community, it's become best practice to combine a Github code repository
with a Travis-CI testing integration for separate packages.
In addition, the [Plone CI team uses Jenkins](http://jenkins.plone.org/) to test the overall Plone integration.

Both Github and Travis are free for public open source projects, but running private
projects on Travis is an expensive proposition. Jenkins can be hard to set up
and maintain, and the user interface is becoming long in the tooth.

Enter Gitlab and Gitlab-CI. [Gitlab](https://gitlab.com) shamelessly replicates most of the [Github](https://github.com) user
experience. But, in contrast to Github, private repositories are for free on Gitlab.
In addition, [Gitlab-CI](https://about.gitlab.com/gitlab-ci/) offers Continuous Integration features for free also.

For a new [Quaive](http://quaive.com) customer project, I needed a private repository with continuous
integration testing. Below I'm sharing with you how you can set up your private Plone
projects on Gitlab-CI, too.

### Overview

These are the steps involved to make this work:

1. Create an account on [Gitlab](https://gitlab.com).
2. Create a repo and push your current code base.
3. Prepare a Docker image to use as a base for Gitlab-CI testing.
4. Prepare your code for Gitlab-CI testing.
5. Configure, start and attach Gitlab-CI test runners.
6. Push your work on any branch and check test results.

You can figure out the first two steps on your own.

If you want to use Gitlab as a second repository and pipeline, in addition to
e.g. an existing Github origin, you can simply add another remote and push there:

``` sh
git remote add gitlab <url>
git push gitlab master
```

### Docker rules

If you're still afraid of Docker, now is the time to overcome that fear.
The way Gitlab-CI uses docker is *awesome* and a gamechanger for testing.
Here's the benefits I'm enjoying:

* Full isolation between test builds and test runners

  We've been wrestling with cross-build pollution on Jenkins,
  especially with the Github pull request builder plugin.
  No such thing on Gitlab-CI, every test run is done in a new,
  pristine Docker container which gets discarded after the run.
* Fully primed cache for fastest buildout possible

  This was the key thing to figure out. On Travis the buildout is typically
  primed by downloading the Plone unified installer, extracting the eggs cache
  from the tar ball and using that to speed up the buildout. That still leaves
  you with running that download plus any extra eggs you need, for every build.
  Not so on Gitlab-CI. I'll explain how to set up your own Docker cache below.
* Unlimited, easily scalable test runners

  The Gitlab-CI controller is for free. The actual test runs need slaves to run
  your builds. What is super neat about Gitlab-CI, is that your test runners can
  run *anywhere*. Even on your laptop. That means you don't have to pay for extra
  server capacity in the cloud: you can just use your desktop, or any machine with
  spare capacity you have, to run the tests.

  Imagine what this does during a sprint. Normally, CI capacity can quickly become
  a bottleneck if lots of developers are pushing a lot of code on the same days.
  Because of the scalable nature of Gitlab-CI, every developer could just add a runner
  on his laptop. Or you could hire a few cheap virtuals somewhere for a few day to
  temporarily quadruple your testing capacity for the duration of the sprint.
* Parallel test runs for faster end results

  As a result of all of the above (fast buildouts, scalable runners) it becomes feasible
  to split a long-running test suite into several partial runs, you then run in parallel.
  At [Quaive](http://quaive.com), a full test run with nearly 900 tests takes the better part of an hour to run.
  Being able to split that into two shorter runs with faster feedback on failures is a boon.

### Prepare a Docker image to use as a base for Gitlab-CI testing

You have to, once, prepare a Docker image with all system dependencies and an eggs cache.
That image will be cached locally on your CI runners and used as a base for every test run.

I use a Docker image with a fully primed cache:

* The [Dockerfile](https://github.com/quaive/ploneintranet-docker-base/blob/master/Dockerfile) pulls in all system dependencies and runs the buildout once,
  on creation of the Docker image.

  docker build -t yourorganisation/yourproject
* The [buildout](https://github.com/quaive/ploneintranet-docker-base/blob/master/buildout.cfg) pulls in all the needed eggs and download sources and stores them
  in a buildout cache. Note that in case of complex buildout inheritance trees the
  simplest thing to do is to just list all eggs alphabetically, like I've done here.
* Once that's done, you create an account on [Docker hub](https://hub.docker.com/) and push your image there:

  docker push yourorganisation/yourproject

Note that Quaive is quite a complex code base. For a less complex Plone project you could
prune the list of installed system packages and eggs. [YMMV](https://github.com/quaive/ploneintranet-docker-base).

### Prepare your code for Gitlab-CI testing

You simply add a .gitlab.yml script that configures the test runs.
This is required and the file must have that name.

In addition, it makes sense to add a specialized gitlab.cfg buildout file, but this
is not required and the name is completely free.

For those of you who have worked with .travis.yml before, this will look very similar:

``` yaml

before_script:
  - export LC_CTYPE=en_US.UTF-8
  - export LC_ALL=en_US.UTF-8
  - export LANG=en_US.UTF-8
  - virtualenv --clear -p python2.7 .
  - bin/pip install -r requirements.txt
  - bin/buildout -c gitlab-ci.cfg
  - /etc/init.d/redis-server start
  - Xvfb :99 1>/dev/null 2>&1 &

robot:
  script:
    - DISPLAY=:99 bin/test -t 'robot'

norobot:
  script:
    - bin/code-analysis
    - bin/test -t '!robot'
    - ASYNC_ENABLED=true bin/test -s ploneintranet.async

```

Here's what's happening:

* before\_script configures the system to be UTF-8 safe, bootstraps the buildout and
  then builds out a gitlab-ci.cfg which is just a normal buildout, but stripped from
  everything not needed in the test. We then start any required services, in our case
  we need redis. A Xvfb virtual framebuffer is needed for the robot tests.

  This before\_script is always run, the rest defines separate CI runners:
* robot runs our robot tests on the virtual framebuffer we just started.
* norobot runs the rest of the tests, plus an extra test run of our async stack
  which does not mock async but actually exercises celery and redis.

So this defines two CI runners, with a shared setup fixture that is used in both.

### Configure, start and attach Gitlab-CI test runners

If you followed the above closely, you'll notice that the Docker image we configured
has not been referenced yet. That follows in this step, which brings everything together.

On your Linux workstation or server you want to use as a host for running the CI tests,
first install Docker:

```

sudo apt-get install docker.io

```

Then, start a runner in auto-reboot mode:

```

docker run -d --name gitlab-runner-01 --restart always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /srv/gitlab-runner-01/config:/etc/gitlab-runner \
gitlab/gitlab-runner:latest

```

If you want to have multiple runners in parallel, repeat the above, replacing
gitlab-runner-01 with gitlab-runner-02 etc.

Now go to your [Gitlab](https://gitlab.com) account. Navigate to your project. In the sidebar,
choose "Settings". Scroll down the sidebar and choose "Runners".

First disable the shared runners provided by Gitlab. They're not suitable for
testing your Plone project.

Now, while keeping this screen open (You'll need to copy the registration token),
go to your Linux terminal again and register the runner you started above,
as a runner for this Gitlab project:

```

docker exec -it gitlab-runner-01 gitlab-runner register

```

This will involve you in something like the following dialog:

```

Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/ci )
https://gitlab.com/ci
Please enter the gitlab-ci token for this runner
xxx copy from Gitlab settings xxx
Please enter the gitlab-ci description for this runner
myhost-runner-01
INFO[0034] fcf5c619 Registering runner... succeeded
Please enter the executor: shell, docker, docker-ssh, ssh?
docker
Please enter the Docker image (eg. ruby:2.1):
yourorganisation/yourproject:latest
INFO[0037] Runner registered successfully.

```

Here in the last question you use the name of the Docker image you pushed to Docker hub before.

Repeat the registration process in case you want to add multiple runners.

That concludes the hard part.

### Push your work on any branch and check test results

Now, any push to any branch on your Gitlab project will trigger the builds you configured.
You can see them in the sidebar of your project under "builds" and you can follow the console
of the build as it's progressing.

What I like about this build system is the "Retry build" button. No more pleading with Jenkins
on Github comments to try and trigger the pull request builder (which happens to ignore the
trigger phrases you configured because it *always only* uses it's own hardcoded triggers).

Also, you don't need to open a fake pull request just to trigger a build. So annoying to open
a pull request overview on Github and see lots of outdated, broken builds which are not really
pull requests but just a hack to get Jenkins going. No more.

### Gotchas

There's two gotchas you need to be aware of here:

* Docker may not have been started properly.

  There's a known race condition between the docker
  service and your firewall which prevents your dockers from running properly. That shows up as
  "hanging" builds in your build overview. The solution is simple: just once after reboot,
  issue a sudo /etc/init.d/docker restart and that should fix it.
* Branch testing on Gitlab is subtly different from pull request testing on Github.

  Gitlab is very straightforward: it tests your branch at the last commit you pushed there.
  The downside of that is, that if your branch is behind master, a merge may result in a broken master,
  even though the branch itself was green. The way to prevent that is to allow only fast-forward
  merges, which you can configure. Personally I have reasons to not always fast-forward. YMMV.

  Github on the other hand, tests your pull request *after virtually merging to master*.
  The upside of that is clearly, that a green PR indicates that it can be safely merged.
  The downside is more subtle. First off, not many developers are aware of this virtual
  merging. So if your branch is behind master it may break for a regression which you
  *cannot reproduce on your branch* because it needs a merge/rebase with master first.
  So you can have an unexplicable failure. The other is also possible: you may have a green
  test result on your PR but still breakage on master, if some other PR got merged in the meantime
  and you did not trigger a new test on the to-be-merged PR.

### Conclusion

On Quaive, we now use Jenkins-CI with Github pull request integration, in parallel with the
Gitlab-CI setup described above. This makes it very easy to triangulate whether a test failure
is caused by code or by the test server. It also provides us with both the benefits of per-branch
per-push Gitlab-CI testing and the *virtual merge* pull request testing of Gitlab + Jenkins.

If you're interested in setting this up for your own projects and running into issues, just
start a thread on community.plone.org and ping me (@gyst), or leave a comment below this post.
