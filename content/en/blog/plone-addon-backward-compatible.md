---
title: "Creating a Plone 6 add-on that is Python 2.7 backward compatible"
description: ""
date: 2025-05-09
author: guidostevens
---

{{< intro >}}
How do you create a modern add-on for Plone 6, that is also backward compatible with Plone 4.3 on Python 2.7 with Archetypes? 
{{< /intro >}}

In this blog post, I'll explain the technical details of creating [collective.collabora](https://github.com/collective/collective.collabora), making it work in many Plone versions, while also providing continuous integration and 100% test coverage.

## Introduction

Collabora Online provides collaborative open source document editing, controlled by you. [collective.collabora](https://github.com/collective/collective.collabora) brings this capability into Plone. It can be used as-is, and works out of the box in about any Plone version.
You can read all about collective.collabora in the [documentation at readthedocs](https://collectivecollabora.readthedocs.io/en/latest/).

Here's a demo of how it works from a user perspective.

{{< youtube_enhanced id="6A7MyogkGcE" >}}


## Contents
{{< toc >}}

## Requirements
We already had a working proof of concept implementation in Quaive, created by Johannes Raggam.
The challenge of this project was, to refactor this to support 3 distinct Plone flavors.

{{< cards >}}
{{< card >}}
### Quaive
Turn the proof of concept into a production-ready Quaive app.
{{< /card>}}
{{< card >}}
### Plone 6.x
Extract the non-Quaive specific code into a re-usable Plone add-on.
{{< /card>}}
{{< card >}}
### Plone 4.3
Backport the Plone 6 add-on to Plone 4.3.
{{< /card >}}
{{< /cards >}}

There is a significant number of Plone 4 sites still in production — not maintained by us, mind you, all our installs run on Plone 6.1.
Making collective.collabora available for Plone 4 will ease the migration to Plone 6. 
It makes it possible to replace External Editor and use Collabora instead, which removes the need to upgrade External Editor.
Plus, of course, the Collabora user experience is much more slick than External Editor, and it does not require a local software component to be installed on each client desktop.

## Bootstrapping the package

I evaluated a number of ways to bootstrap the add-on python package.
From the options listed below, in the end I chose to go with [PloneCLI](https://pypi.org/project/plonecli/).

### Key references

-   [Packaging Python Projects](../references/PackagingPythonProjects.md)
-   [pyproject.toml](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/) declaration
-   installation/build [replacement commands for setuptools](https://packaging.python.org/en/latest/discussions/setup-py-deprecated/#setup-py-deprecated)

#### Testing framework references

1.  Tox

    Use [tox](https://christophergs.com/python/2020/04/12/python-tox-why-use-it-and-tutorial/) to drive testing:
    
    -   multi-python support
    -   replaces buildout for non-Plone projects.

2.  Pytest

    [Pytest versus unittest](https://builtin.com/data-science/pytest-vs-unittest): it's not a big deal to write tests in [pytest](https://docs.pytest.org/en/stable/).
    In Plone projects, [pytest-plone](https://pypi.org/project/pytest-plone/) provides plone layer support for pytest (for an example see cookiecutter-plone)

3.  Github Actions

    Github actions can use the tox matrix via [tox-gh-actions](https://github.com/ymyzk/tox-gh-actions). See [collective.collabora fixup](https://github.com/collective/collective.collabora/commit/d6c5401530bce69e4992fd93594aea975876131a).


### Manual

Alessandro creates his packages manually. That's always an option, but I prefer the convenience of a batteries-included template, if possible.


### Pyscaffold

[Pyscaffold](https://pyscaffold.org/en/latest/index.html) is a generic high-quality Python package generator. 
Includes `pytest` based tests outside of `src`.

1.  Downsides

    -   Does not provide a [namespaced package](https://packaging.python.org/en/latest/guides/packaging-namespace-packages/) out of the box. See below for easy fix.
    -   Does not provide a [Github workflow for CI](https://docs.github.com/en/actions/writing-workflows/quickstart).

2.  Upsides

    -   Minimalistic
    -   comes with `pyproject.toml`
    -   comes with `tox.ini`
    -   super minimal `setup.py`

3.  Usage

    ``` sh
    pipenv install pyscaffold
    putup collective.collabora
    cd collective.collabora
    tox
    ```

    No questions asked!

4.  Further tuning

    1.  Turn into a namespaced package

        ``` sh
        rg -l collectivecollabora . | xargs sed -i -e 's/collectivecollabora/collective.collabora/g'
        sed -i -e 's#src/collective.collabora#src/collective/collabora#' src/docs/conf.py
        cd src
        mkdir collective
        git mv collectivecollabora/ collective/collabora
        cd ..
        tox
        git commit -am "Turn package into a namespaced package"
        ```
        
        This uses implicit namespaces. No need to declare anything.
    
    2.  Add github workflows
    
        See [Github actions](https://docs.github.com/en/actions/writing-workflows/quickstart) documentation.

Use this for non-Plone packages.

### PloneCLI

[PloneCLI](https://pypi.org/project/plonecli/) provides mr.bob templates, which is great for Plone projects.
Includes `unittest` based tests within `src`

1.  Downsides

    -   It does not add a `pyproject.toml`
    -   All info is in `setup.py`

2.  Upsides

    -   Comes with a `tox.ini`
    -   Supports namespaced packages
    -   Includes browser, profiles, locales
    -   Comes with `buildout` configured
        -   Includes `mr.developer` support
        -   Extends the regular [plone test runner](https://raw.githubusercontent.com/collective/buildout.plonetest/master/test-6.0.x.cfg) and [qa tooling](https://raw.githubusercontent.com/collective/buildout.plonetest/master/qa.cfg)

3.  Usage

    ``` sh
    sudo apt install pipenv
    pipenv install plonecli
    pipenv shell
    plonecli create addon collective.collabora
    cd collective.collabora
    tox
    ```

4.  Further tuning

    -   See [collective.collabora fixup](https://github.com/collective/collective.collabora/commit/d6c5401530bce69e4992fd93594aea975876131a).
    -   Add a [pyproject.toml](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/) declaration.
    -   Perhaps apply [plone.meta](https://github.com/plone/meta) and especially [config](https://github.com/plone/meta/tree/main/config).
    -   See e.g. [collective.timestamp](https://github.com/collective/collective.timestamp/commit/d345ff5d021cca149a36080ab9882b19a12609c7) initial commit

Best match for Plone Classic projects.


### Cookieplone

[Cookieplone](https://pypi.org/project/cookieplone/) provides a `backend_addon` template that emits a valid package.

1.  Downsides

    -   This uses [mxdev](https://github.com/mxstack/mxdev) instead of zc.buildout.
    -   Has `pytest` based tests, outside of `src`
    -   Includes lots of plone backend modules, but no `browser`

2.  Upsides

    -   Comes with `pyproject.toml` including `towncrier` support
    -   Comes with `tox.ini`
    -   Supports namespaced packages
    -   Provides plone layer support in `tests/conftest.py`

3.  Usage

    ```sh
    pipenv install cookieplone
    pipenv run cookieplone backend_addon
    cd collective.collabora
    tox
    ```

Since I'm not interested in creating content types, but want to create browser views and prefer the more traditional buildout and zope testrunner, this is not a good match for this project.

### Cookiecutter-plone-starter

1.  Downsides

    -   Needs a new npm install
    -   Asks a shitload of configuration questions
    -   Emits a load of Volto code that is not even a valid package

2.  Usage
    ``` sh
    pipenv run cookiecutter gh:collective/cookiecutter-plone-starter
    ```
        

Since we're doing Plone Classic here, not React, that's not a good match.

Oh, and meanwhile this approach has been [deprecated](https://github.com/collective/cookiecutter-plone-starter/commit/8437a936e2a5d12e8d24383e4d9376bf6b552923).

## Development environment

I always like my projects to be fully scripted. The goal is, to not have any
undocumented commands. If I return to a project after a year, on a new laptop, I
don't want to waste time on re-figuring out required steps I performed manually,
without documenting them.

### System dependencies
I isolate my system dependencies in a docker container. The relevant `Dockerfile` snippet is:

``` docker
RUN add-apt-repository ppa:deadsnakes/ppa -y

RUN apt-get update && apt-get install -y \
    python2.7-dev \
    python3.8-dev python3.8-venv python3.8-distutils \
    python3.9-dev python3.9-venv python3.9-distutils \
    python3.10-dev python3.10-venv python3.10-distutils \
    python3.11-dev python3.11-venv python3.11-distutils \
    python3.12-dev python3.12-venv \
    python3.13-dev python3.13-venv

RUN pip3 install tox black==22.8.0 pre-commit future zest.releaser i18ndude sphinx
```

That's for an image based on `ubuntu:22.04`.
This gets me all the required Python versions and the tooling I need that are not part of the package requirements itself.

### Makefile
The [Makefile](https://github.com/collective/collective.collabora/blob/main/Makefile)
scripts all commands within the (containerized) development environment. 


### Tox

A project like this would be much harder without [Tox](https://tox.wiki/).
We're supporting 4 Plone versions on 7 Python versions, for 11 supported Python/Plone version combos in total.
You'd go insane trying to manage those virtualenvs manually.
Actually, even with Tox it wasn't that easy.

A good primer on Tox is [Python tox - Why You Should Use It and Tutorial](https://christophergs.com/python/2020/04/12/python-tox-why-use-it-and-tutorial/).

Tox is configured through [tox.ini](https://github.com/collective/collective.collabora/blob/main/tox.ini). Let's have a look.

#### Version Matrix

The version matrix we want to support is defined as follows.
I took the supported Python versions for Plone from the `setup.py` of Plone itself.

``` ini
[tox]

# support python2.7
requires = virtualenv<20.22.0

# old tox needs spaces in multi factors
# https://github.com/tox-dev/tox/issues/899
# we also have unlisted environments: black-enforce isort-apply
envlist =
    black-check,
    py{38, 39, 310, 311, 312, 313}-lint,
    py{310, 311, 312, 313}-Plone{61},
    py{39, 310, 311, 312}-Plone{60},
    # py27 tests are ignored on Github, but active when run locally
    py{27, 38}-Plone{52},
    # NB Plone43 tests provide their own built-in DX/AT test matrix
    py{27}-Plone{43},
    coverage-report,

```

The downpinning of virtualenv and other Python 2.7 / Archetypes related things I will cover below.

As the comment notes, spaces in Tox factors can trip you up. Depending on your Tox version, 
something like `py{27,38}-Plone{52}`will break, and you will waste time you find out it needs to be `py{27, 38}-Plone{52}` with a space after the comma.

#### Running a specific version from the matrix 

``` ini
[testenv]
skip_install = true

extras =
    develop
    test

commands =
    {envbindir}/buildout -q -c {toxinidir}/{env:version_file} \
        buildout:directory={envdir} buildout:develop={toxinidir} \
        bootstrap
    {envbindir}/buildout -n -qq -c {toxinidir}/{env:version_file} \
        buildout:directory={envdir} buildout:develop={toxinidir} \
        install test
    coverage run {envbindir}/test -v1 --auto-color {posargs}
    coverage report -m

setenv =
    COVERAGE_FILE={toxinidir}/.coverage.{envname}
    PYTHONWARNINGS=default,ignore::DeprecationWarning
    Plone43: version_file=test_plone43.cfg
    Plone52: version_file=test_plone52.cfg
    Plone60: version_file=test_plone60.cfg
    Plone61: version_file=test_plone61.cfg

deps =
    Plone43: -rrequirements_plone43.txt
    Plone52: -rrequirements_plone52.txt
    Plone60: -rrequirements_plone60.txt
    Plone61: -rrequirements_plone61.txt
    coverage
    py27: -cconstraints_py27.txt

```

When running a specific version to test, say `tox -e py312-Plone61`, tox first provisions a dedicated virtualenv for this version. 
Then (removing the plumbing of directory paths here for readability) the execution boils down to:

``` sh
pip install -rrequirements_plone61.txt
buildout bootstrap
buildout install test
coverage run test
coverage report -m
```

Note that `requirements_plone61.txt` itself applies the constraints: `-c constraints_plone61.txt`, which in turn pulls in the upstream constraints: `-c https://dist.plone.org/release/6.1-latest/constraints.txt`. In addition, the local requirements and constraints contain version pins for our own tooling.

Likewise, the buildout configuration `test_plone61.cfg` pulls in the upstream `https://raw.githubusercontent.com/collective/buildout.plonetest/master/test-6.1.x.cfg` from and adds some local version pins.

The work to support all version combinations in our version matrix then decomposes into getting this call flow to work for each version combo, by making sure the requirements, constraints, and buildout configurations are in order.

#### Development environments
What's important, is that Tox is not just good at managing test environments — in this project I'm using it to manage my development environments as well. Those are separate from the virtualenvs used for testing. You can use these development environments for interactive development and testing, interacting with a live Plone site in a specific Python/Plone version combo you want to develop against.

To get a specific development environment up and running, these are the steps executed if you invoke: `make start61`:

``` sh
tox --devenv ./dev61 -e py312-Plone61
./dev61/bin/pip install -r requirements_plone61.txt
./dev61/bin/buildout -c ./dev_plone61.cfg \
    buildout:directory=$(CURDIR)/dev61 buildout:develop=$(CURDIR) \
    bootstrap
./dev61/bin/buildout -c ./dev_plone61.cfg \
    buildout:directory=$(CURDIR)/dev61 buildout:develop=$(CURDIR) \
    install
./dev61/bin/instance fg
```

The main additional trick I performed for the development configurations, is to each put them on a distinct port, so that I can easily run the stack in four different version flavours, each in its own browser tab. `dev_plone61.cfg` configures Plone61 to run on `:6180`:

``` ini
[instance]
http-address = 6180
```

#### Local test runs

I found that if I just run `tox -p`, i.e. run all test jobs in parallel maxing out all available CPU cores, I get failing jobs sometimes. So instead I'm executing tox in such a way that it leaves one of my CPU cores unutilized.
```
❯❯ tox -p 7
ROOT: will run in automatically provisioned tox, host /usr/bin/python3 is missing [requires (has)]: virtualenv<20.22.0 (20.30.0)
ROOT: provision    .tox/.tox/bin/python -m tox -p 7
black-check: OK ✔ in 0.95 seconds
py311-lint: OK ✔ in 1.01 seconds
py312-lint: OK ✔ in 1.02 seconds
py313-lint: OK ✔ in 1.03 seconds
py39-lint: OK ✔ in 1.03 seconds
py310-lint: OK ✔ in 1.05 seconds
py38-lint: OK ✔ in 1.05 seconds
py313-Plone61: OK ✔ in 21.54 seconds
py310-Plone60: OK ✔ in 21.78 seconds
py310-Plone61: OK ✔ in 22.6 seconds
py311-Plone60: OK ✔ in 22.91 seconds
py39-Plone60: OK ✔ in 23.1 seconds
py312-Plone61: OK ✔ in 24.11 seconds
py312-Plone60: OK ✔ in 19.97 seconds
py27-Plone52: OK ✔ in 22.2 seconds
py38-Plone52: OK ✔ in 23.41 seconds
py27-Plone43: OK ✔ in 23.91 seconds
py311-Plone61: OK ✔ in 1 minute 23.2 seconds
coverage-report: commands[0]    coverage erase
coverage-report: commands[1]    coverage combine
Combined data file .coverage.py27-Plone43
Combined data file .coverage.py27-Plone52
Combined data file .coverage.py310-Plone60
Combined data file .coverage.py310-Plone61
Combined data file .coverage.py311-Plone60
Combined data file .coverage.py311-Plone61
Combined data file .coverage.py312-Plone60
Combined data file .coverage.py312-Plone61
Combined data file .coverage.py313-Plone61
Combined data file .coverage.py38-Plone52
Combined data file .coverage.py39-Plone60
coverage-report: commands[2]    coverage report -m
Name                                           Stmts   Miss  Cover   Missing
----------------------------------------------------------------------------
src/collective/__init__.py                         1      0   100%
src/collective/collabora/__init__.py               5      0   100%
src/collective/collabora/adapters.py              48      0   100%
src/collective/collabora/browser/__init__.py       0      0   100%
src/collective/collabora/browser/edit.py         140      0   100%
src/collective/collabora/browser/wopi.py          86      0   100%
src/collective/collabora/interfaces.py            13      0   100%
src/collective/collabora/setuphandlers.py         11      0   100%
src/collective/collabora/tests/__init__.py         0      0   100%
src/collective/collabora/utils.py                 40      0   100%
----------------------------------------------------------------------------
TOTAL                                            344      0   100%
  black-check: OK (0.95=setup[0.38]+cmd[0.56] seconds)
  py38-lint: OK (1.05=setup[0.44]+cmd[0.02,0.44,0.15] seconds)
  py39-lint: OK (1.03=setup[0.40]+cmd[0.06,0.42,0.16] seconds)
  py310-lint: OK (1.05=setup[0.45]+cmd[0.01,0.42,0.17] seconds)
  py311-lint: OK (1.01=setup[0.38]+cmd[0.08,0.44,0.12] seconds)
  py312-lint: OK (1.02=setup[0.44]+cmd[0.01,0.37,0.19] seconds)
  py313-lint: OK (1.02=setup[0.45]+cmd[0.01,0.47,0.10] seconds)
  py310-Plone61: OK (22.60=setup[0.15]+cmd[1.75,2.72,17.48,0.50] seconds)
  py311-Plone61: OK (83.20=setup[0.15]+cmd[1.51,66.67,14.37,0.50] seconds)
  py312-Plone61: OK (24.11=setup[0.23]+cmd[1.41,2.68,19.29,0.50] seconds)
  py313-Plone61: OK (21.54=setup[0.31]+cmd[1.58,2.55,16.61,0.48] seconds)
  py39-Plone60: OK (23.10=setup[0.32]+cmd[1.45,3.05,17.52,0.76] seconds)
  py310-Plone60: OK (21.78=setup[0.28]+cmd[1.44,2.68,16.58,0.80] seconds)
  py311-Plone60: OK (22.91=setup[0.31]+cmd[1.51,2.49,18.11,0.47] seconds)
  py312-Plone60: OK (19.97=setup[0.22]+cmd[1.21,2.17,15.93,0.44] seconds)
  py27-Plone52: OK (22.20=setup[0.22]+cmd[1.39,5.90,14.17,0.51] seconds)
  py38-Plone52: OK (23.40=setup[0.21]+cmd[1.48,7.98,13.29,0.46] seconds)
  py27-Plone43: OK (23.91=setup[0.18]+cmd[1.50,5.60,16.10,0.54] seconds)
  coverage-report: OK (5.86=setup[0.02]+cmd[0.09,0.73,5.02] seconds)
  congratulations :) (90.12 seconds)
```

## Continuous Integration

Continuous integration uses Github actions. 
We're using the [tox-gh-actions plugin for tox](https://github.com/ymyzk/tox-gh-actions) to leverage the tox setup also for continuous integration. 
Note that in the process of getting this to work, I ran into problems and bugs that required workarounds, see below.

The configuration is defined in two places.

### gh-actions in tox.ini

The plugin requires some configuration in [tox.ini](https://github.com/collective/collective.collabora/blob/main/tox.ini) to be set.


``` ini

[gh-actions]
python =
    '2.7': py27
    '3.8': py38
    '3.9': py39
    '3.10': py310
    '3.11': py311
    '3.12': py312
    '3.13': py313


[gh-actions:env]
PLONE_VERSION =
    Plone43: Plone43
    Plone52: Plone52
    Plone60: Plone60
    Plone61: Plone61

PLATFORM =
    lint: lint

```

### Github workflow definition

The Github workflow is defined in [.github/workflows/plone-package.yml](https://github.com/collective/collective.collabora/blob/main/.github/workflows/plone-package.yml).

Getting that to work required significant changes versus the boilerplate that was generated by PloneCLI.

The main problem is, no proper version matrix support. Perhaps the matrix for this project is too complex — though Tox itself handles it just fine.
Instead of listing valid Python-Plone combinations through wildcard notation, like `py{310, 311, 312, 313}-Plone{61}`, the approach for Github actions
is to list both factors (Python, Plone) separately, for which it will take the cross-product; you then exclude the invalid combinations.

``` yaml
build_and_test_py3:
    runs-on: ubuntu-latest
    strategy:
        fail-fast: false
        matrix:
          python-version: ['3.8', '3.9', '3.10', '3.11', '3.12', '3.13']
          plone-version: ['Plone52', 'Plone60', 'Plone61']
          # While tox skips invalid matrix combinations, Github actions does
          # schedule and fail jobs for these. So exclude them. We could also
          # use include instead, but then the job names do not contain the
          # Plone version.
          exclude:
            - python-version: '3.8'
              plone-version: 'Plone60'
            - python-version: '3.8'
              plone-version: 'Plone61'
            - python-version: '3.9'
              plone-version: 'Plone52'
            - python-version: '3.9'
              plone-version: 'Plone61'
            - python-version: '3.10'
              plone-version: 'Plone52'
            - python-version: '3.11'
              plone-version: 'Plone52'
            - python-version: '3.12'
              plone-version: 'Plone52'
            - python-version: '3.13'
              plone-version: 'Plone52'
            - python-version: '3.13'
              plone-version: 'Plone60'
```


It then performs a number of steps for each supported version combo:
1. Checkout the source code
2. Set up the right python version
3. Compute a cache hash for this python-plone combo
4. Configure the buildout cache
5. Install the `tox-gh-actions` plugin
6. Use tox to run the tests
7. Upload the coverage data (so we can combine them across version combinations)


See the resulting [.github/workflows/plone-package.yml](https://github.com/collective/collective.collabora/blob/main/.github/workflows/plone-package.yml) for full reference of a working setup.

Note that Github actions does not support Python 2.7, even though that is supported in local test runs.
I found and tried a number of documented workarounds, but none of them actually worked, so I just gave up on including Python 2.7 runs on Github actions.

## Python 2.7

I've worked with Plone since it was in version 2.1. Back in the day, we did a good number of projects in Plone 4 on Python 2.7.
But that was a *loooong* time ago.

Because Plone provided a clear and structured upgrade path from Plone 4 to Plone 6, I could backport the collective.collabora package
in discrete steps, by reversing the upgrade path:

1. Backport to Plone 5.2 on Python 3.
2. Backport to Plone 5.2 on Python 2.7.
3. Backport to Plone 4.3 with Dexterity.
4. Backport to Plone 4.3 with Archetypes.

In other words, the backporting journey was: Plone 6 >> Plone 5 >> Python 2.7 >> Plone 4 >> Archetypes.

The Plone5 backport was uneventful.

Python 2.7, as you can imagine, was more work. The full backport I performed is documented in a [pull request](https://github.com/collective/collective.collabora/pull/5/files). Let me give you the highlights.


### downpinning packages

A key intervention was, to configure tox.ini to downpin virtualenv to the last version that is compatible with Python 2.
This applies across the range of supported versions.

```ini
[tox]
# support python2.7
requires = virtualenv<20.22.0
```

Specifically for python2.7 environments, the following pins were made:
```
setuptools==42.0.2
zc.buildout==2.13.8
future==0.18.2

coverage==5.5
mock==3.0.5
```
### Python-Future 

[Python-Future](https://python-future.org/) "is the missing compatibility layer between Python 2 and Python 3. It allows you to use a single, clean Python 3.x-compatible codebase to support both Python 2 and Python 3 with minimal overhead."

It comes with a script called `pasteurize` that you can use, to make existing Python 3 code cross-compatible between Python 2 and Python 3.

That typically means, performing some special imports at the top of each module, then activating the monkey-patching hook.
For example:

``` python
from __future__ import unicode_literals

from builtins import dict
from builtins import filter
from builtins import next
from builtins import super
from future import standard_library

# plone.api.portal.get_registry_record expects a native string in py27
from future.utils import bytes_to_native_str as n


standard_library.install_aliases()

```

### Not so super

Newsuper throws an infinite loop in py27. Fixed by using old-style explicit `super(cls, self)`:

```python
super(BrowserView, self).__init__(context, request)
```


### String mangling

Getting registry records requires native strings in python2.7.

``` python
server_url = api.portal.get_registry_record(
    n(b"collective.collabora.server_url"), default=None
)
```

Using a raw PosixPath in py27 throws `TypeError: invalid file: PosixPath('/collective.coll...`,

Fixed by wrapping it into a string cast:

```python

with open(str(TESTDATA_PATH / "testfile.docx"), "br") as fh:
```

### No f-strings

This one felt like a finger being chopped off: having to fall back on oldskool `%s` string interpolations.

```python
args = dict(
    WOPISrc="%s/@@cool_wopi/files/%s" % (document_url, uuid),
```

### No f-strings in templates, either

Another finger getting chopped off. I had to replace things like
```
href="${view/download_url}"
```
with 
```
tal:attributes="href view/download_url;"
```

and I had to learn to use `tal:content` again.

### plone.protect

The plone.protect version compatible with Plone 4.3 does not provide a `safeWrite` function.
So initially I backported that function into a local monkeypatch.

In the end, bypassing CORS protections was not such a good idea and I dropped that,
opting instead for adding a plone.protect `_authenticator_` token to all requests that
needed it — and the code for doing that *was* already available in Plone 4.3.

## Archetypes

### Adaptation to the rescue

The main problem with Archetypes, in our usecase, was that the way of storing File objects
is so different from Dexterity. Since what collective.collabora does is mainly reading and storing Files.

We have the Zope Component Architecture exactly for that class of problem.

``` python

class IStoredFile(Interface):
    """Support a minimal set of File accessors across AT and DX.

    This provides a subset of DX INamedBlobFile.
    
    We register adapters against this custom interface, rather than against
    INamedFile itself, to ensure there cannot be any accidental use of this
    adaptation beyond our narrow use case.
    """
    data = Attribute("file data")
    filename = Attribute("file name")
    contentType = Attribute("content type")

    def getSize():
        """file size"""
```

This follows the Dexterity interface contract for interacting with files.
I then created and registered [adapters for this interface](https://github.com/collective/collective.collabora/blob/main/src/collective/collabora/adapters.py).


```python
@adapter(IFile)
@implementer(IStoredFile)
class DXStoredFile(object):
    """Access the file storage on a Dexterity content object.

...
```

```python
@adapter(IATFile)
@implementer(IStoredFile)
class ATStoredFile(object):
    """Access the file storage on a Archetypes content object.
    
...
```

This then encapsulates and shields us from the weirdness in Archetypes, where the `File` content type contains a `file` field,
that in turn requires access to the `File` to know its filename. Ugh.

This adapter then is used in both production code and tests:

```python
self.stored_file = IStoredFile(self.context)

...

return {
    "BaseFileName": self.stored_file.filename,
    "Size": self.stored_file.getSize(),
```

### Testing Plone4 against both Dexterity and Archetypes

Our tox matrix supports two dimensions: python, and plone. I was not going to introduce a third dimension, to be able to test
both Dexterity and Archetypes on the same python-plone combination.

Instead, I built the path divergence into the tests.

#### Executing the test suite twice

The tests are executed twice, via subclassing: once for Dexterity, once for Archetypes:

```python

class TestCoolWOPI(unittest.TestCase):
    """Test user interface view."""

    layer = COLLECTIVE_COLLABORA_INTEGRATION_TESTING
    
...

@unittest.skipUnless(utils.IS_PLONE4, "Archetypes tested only in Plone4")
class TestCoolWopiAT(TestCoolWOPI):
    """Test user interface view against Archetypes."""

    layer = AT_COLLECTIVE_COLLABORA_INTEGRATION_TESTING
```

#### Varying the ZCA configuration within a test

The tests are made aware of whether they're testing Archetypes or Dexterity.
In [testing.py](https://github.com/collective/collective.collabora/blob/61d1e62e4ddde9c7fa7e81466bea0945cc763f76/src/collective/collabora/testing.py#L111):

```python
class IntegrationTesting(BaseIntegrationTesting):
    """Provide an integration test case aware of AT vs DX"""

    @property
    def IS_DX(self):
        return self.__bases__[0].IS_DX
```

which is then used within a test method to provide the correct configuration within tests:

```python
if self.layer.IS_DX:
    gsm.registerHandler(
        event_handler, (IFile, zope.lifecycleevent.IObjectModifiedEvent)
    )
    try:
        payload = view.wopi_put_file()
    finally:
        gsm.unregisterHandler(
            event_handler, (IFile, zope.lifecycleevent.IObjectModifiedEvent)
        )

else:
    from Products.ATContentTypes.interfaces import IATFile

    gsm.registerHandler(
        event_handler, (IATFile, zope.lifecycleevent.IObjectModifiedEvent)
    )
    try:
        payload = view.wopi_put_file()
    finally:
        gsm.unregisterHandler(
            event_handler, (IATFile, zope.lifecycleevent.IObjectModifiedEvent)
        )
```

#### Skipping some tests

Some tests that were not testing Archetypes-specific functionality, still broke
because of breakage elsewhere in the stack. Since these tests are already
executed in other Plone/Python versions, I was comfortable skipping some.

```python
@unittest.skipIf(utils.IS_PLONE4, 
                 "Archetypes is too convoluted to support fixture")
@mock.patch("requests.get")
def test__call__editor_url_invalid_mimetype(self, requests_get):
...
```

## Building and releasing eggs

Let me document the steps I took to establish a valid `collective.collabora` release process.

The main challenge here, is that the released package needs to be valid in python 2.7.

### Problem

For `collective.collabora` I chose to initialize the package using PloneCLI. I then leveraged `tox` to get cross-platform development and testing environments for many Python and Plone versions.

Now the challenge is, to consistently release this package in such a way, that it also builds correctly on all these versions, especially also on the ancient Python 2.7 Plone 4.3 buildout.

In the past months (winter 2025), we've seen tons of breakage in the build chain. Setuptools keeps shifting the goalposts. Building a project now with the current setuptools, will build `collective_collabora` with an underscore instead of `collective.collabora`.


### Goal

Normally I'd use `zest.releaser` to release packages. The initial 0.9.0 release of collective.collabora was done manually by Alessandro. Let's see if I can:

-   test the currently released egg, by removing mr.developer from the dev envs
-   get a working testpypi roundtrip using zest.releaser that works in all dev envs


### Configure build backend

Latest `setuptools` is known to build the wrong package name `collective_collabora`. So I configured `pyproject.toml` with a downpinned setuptools conform instructions of Maurits:

``` ini
[build-system]
requires = ["setuptools<69"]
build-backend = "setuptools.build_meta"
```


### Try zest.releaser

I tried my luck with

`❯❯ fullrelease`

    Python recognizes 'collective.collabora.browser.static' as an importable package,
    but it is absent from setuptools' `packages` configuration.

    This leads to an ambiguous overall configuration. If you want to distribute this
    package, please make sure that 'collective.collabora.browser.static' is explicitly added
    to the `packages` configuration field.

    Alternatively, you can also rely on setuptools' discovery methods
    (for example by using `find_namespace_packages(...)`/`find_namespace:`
    instead of `find_packages(...)`/`find:`).

Ouch. Not so good.

### Switch to manual build and upload

That's [documented on Twine](https://twine.readthedocs.io/en/stable/).

#### Fix the namespace error

```diff
diff --git a/setup.py b/setup.py
index 16d132b..1ff7241 100644
--- a/setup.py
+++ b/setup.py
@@ -1,7 +1,7 @@
 # -*- coding: utf-8 -*-
 """Installer for the collective.collabora package."""

-from setuptools import find_packages
+from setuptools import find_namespace_packages
 from setuptools import setup


@@ -50,7 +50,7 @@ setup(
         "Documentation": "https://collective.collabora.readthedocs.io/en/latest/",
     },
     license="GPL version 2",
-    packages=find_packages("src", exclude=["ez_setup"]),
+    packages=find_namespace_packages("src", exclude=["ez_setup"]),
     # keep deprecated namespace_packages for backward compatibility
     namespace_packages=["collective"],
     package_dir={"": "src"},
```

#### Build

`❯❯ python -m build`

That worked now.

#### 2. Try to upload to Test PyPI

`❯❯ twine upload -r testpypi --verbose dist/*`

I added the `--verbose` flag.

I had already created an account on test.pypi and added that to my `.pypirc`.

<del>Twine will prompt for your username and password.</del>   — that turns out to be outdated Twine documentation. See below.

Upload. Got an error `400 Bad Request`. Turns out, I should add `legacy` to the URL.

Upload. Got an error `405 Method Not Allowed`. Turns out, the repository URL <span class="underline">must have a trailing slash</span>. Fixed that in `.pypirc`.

Upload. Got an error `403 Invalid or non-existent authentication information.` Turns out, I should not use the login `username` and `password` as-is. Because of 2FA, I needed to create an API token and put *that* in `.pypirc`.

Resulting `.pypirc` stanza:

``` ini
[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = pypi-AgE....
```

Upload. Wheel gives a `200 OK` but .tar.gz gives a `400 Bad Request`:

    400 The description failed to render in the default format of reStructuredText. 
    See <https://test.pypi.org/help/#description-content-type> for more information.

#### Fix the RestructuredText problem

First reproduce the issue without uploading:

    $ twine check --strict dist/collective.collabora-0.9.1a2.tar.gz
    Checking dist/collective.collabora-0.9.1a2.tar.gz: FAILED due to warnings
    WARNING  `long_description_content_type` missing. defaulting to `text/x-rst`.

Configure the long description content type.

``` diff
diff --git a/setup.py b/setup.py
index 0fe0259..d8916b0 100644
--- a/setup.py
+++ b/setup.py
@@ -18,6 +18,7 @@ setup(
     version="0.9.1a2",
     description="Collabora Online integration for Plone",
     long_description=long_description,
+    long_description_content_type="text/x-rst",
     # Get more from https://pypi.org/classifiers/
     classifiers=[
         "Development Status :: 4 - Beta",
```

Rebuild:

`❯❯ python3 -m build`.

Check build:

    $ twine check dist/collective.collabora-0.9.1a2.tar.gz
    Checking dist/collective.collabora-0.9.1a2.tar.gz: PASSED

Try to upload again:

`❯❯ twine upload -r testpypi --verbose dist/*`

Fails because the wheel already exists. Upload only the .tar.gz:

`❯❯ twine upload -r testpypi --verbose dist/collective.collabora-0.9.1a2.tar.gz`

`200 OK`.


### Now try a fullrelease roundtrip

`❯❯ fullrelease` with a version bump works.


#### Test the buildouts

I already had put in place egg-based buildouts.
Now I need to get them to load alpha releases from testpypi:

```diff
diff --git a/base.cfg b/base.cfg
index 27a30a9..03e0cea 100644
--- a/base.cfg
+++ b/base.cfg
@@ -1,6 +1,10 @@
 [buildout]
 show-picked-versions = true

+# remove these after testing the build
+find-links += https://test.pypi.org/simple
+prefer-final = false
```

`❯❯ make clean eggs`

Verify the right egg is built in:

`❯❯ head egg*/bin/instance`

It's not. But I had already seen that from the version pinning output.


#### Try a manual install

Inspecting <https://test.pypi.org/simple/    I did not see `collective.collabora` listed. But the project page itself showed the releases. After twiddling around a bit, this is the correct invocation to test the download in isolation:

`❯❯ python3 -m pip install --no-dependencies --index-url https://test.pypi.org/simple/ collective.collabora==0.9.1a3`

That works.

Cleanup:

`❯❯ pip uninstall collective.collabora`


#### Buildout again

Added a hard pin to invalidate the 0.9.0 version that is on pypi:
``` diff
diff --git a/base.cfg b/base.cfg
index 03e0cea..1947d9f 100644
--- a/base.cfg
+++ b/base.cfg
@@ -110,4 +110,4 @@ scripts =
 [versions]
 # Don't use a released version of collective.collabora
-collective.collabora =
+collective.collabora = 0.9.1a3
```

`❯❯ rm -rf egg61 && make egg61`

    While:
      Installing instance.
      Getting distribution for 'collective.collabora[test]==0.9.1a3'.
    Error: Couldn't find a distribution for 'collective.collabora[test]==0.9.1a3'.

Try to configure `index` instead of `find-links`.

``` diff
diff --git a/base.cfg b/base.cfg
index 03e0cea..814aed8 100644
--- a/base.cfg
+++ b/base.cfg
@@ -2,7 +2,7 @@
 show-picked-versions = true

 # remove these after testing the build
-find-links += https://test.pypi.org/simple
+index += https://test.pypi.org/simple
 prefer-final = false

 parts =
```

`❯❯ rm -rf egg61 && make egg61`

    root: Not found:
    <https://test.pypi.org/simple/collective.collabora/>
    root: Couldn't retrieve index page for 'collective.collabora'
    root: Scanning index of all packages (this may take a while)
    root: Not found:
    <https://test.pypi.org/simple/>

Scanning that page in Firefox shows a long package list. Which does **not** contain `collective.collabora` indeed, when doing `Ctrl-F` in the browser.

After some iterations on `base.cfg` I got it to work. This is the cumulative `base.cfg` diff:

``` diff
diff --git a/base.cfg b/base.cfg
index 03e0cea..4711a04 100644
--- a/base.cfg
+++ b/base.cfg
@@ -2,7 +2,8 @@
 show-picked-versions = true

 # remove these after testing the build
-find-links += https://test.pypi.org/simple
+index = https://test.pypi.org/simple/
+find-links += https://test.pypi.org/simple/
 prefer-final = false

 parts =
```

No version pin needed.

`❯❯ rm -rf egg61 && make egg61`

    The following part definition lists the versions picked:
    [versions]
    collective.collabora = 0.9.1a3


#### Build all egg deployments

`❯❯ make clean eggs`

That breaks on python 2.7.

      File "/tmp/easy_install-Bodq0l/collective.collabora-0.9.1a3/setup.py", line 4, in <module>
    ImportError: cannot import name find_namespace_packages


### Fix python2.7

#### Use find-packages

```diff
diff --git a/setup.py b/setup.py
index 587da9c..a5b144b 100644
--- a/setup.py
+++ b/setup.py
@@ -1,7 +1,14 @@
 # -*- coding: utf-8 -*-
 """Installer for the collective.collabora package."""

-from setuptools import find_namespace_packages
+try:
+    # find_packages errors out on py3 on non-python packages
+    from setuptools import find_namespace_packages
+except ImportError:
+    # python 2.7 has no find_namespace_packages
+    # but works fine with find_packages
+    from setuptools import find_packages as find_namespace_packages
+
 from setuptools import setup
```
     
#### Verify the release roundtrip

`❯❯ fullrelease`


#### Rebuild again

`❯❯ make clean eggs`

Verify that the correct egg is loaded

`❯❯ head egg*/bin/instance`

0.9.1a4 everywhere, except in egg61.

`❯❯ rm -rf egg61 && make egg61`

OK now it picks the right version.
Ah, `make clean` did not yet nuke the eggs builds. Fixed.


#### Verify build is good

For each of the 5 main versions:

-   start the instance in foreground
-   create a Plone site
-   install collective.collabora
-   upload a File
-   open in collabora
-   make a change and save

This all works from a build perspective, but throws up `plone.protect` issues in Plone52 on both python versions, and on 60 and 61. Only not on 43.


### End result: zest.releaser workflow works

The build/release/buildout cycle now works correctly. 

#### final diff solving all build problems
Resulting diff, with only the relevant changes (excluding the testpypi and testing non-final releases bits):

``` diff
diff --git a/pyproject.toml b/pyproject.toml
new file mode 100644
index 0000000..360343a
--- /dev/null
+++ b/pyproject.toml
@@ -0,0 +1,3 @@
+[build-system]
+requires = ["setuptools<69"]
+build-backend = "setuptools.build_meta"

diff --git a/setup.py b/setup.py
index 9b81151..2b8d96a 100644
--- a/setup.py
+++ b/setup.py
@@ -1,7 +1,14 @@
 # -*- coding: utf-8 -*-
 """Installer for the collective.collabora package."""

-from setuptools import find_packages
+try:
+    # find_packages errors out on py3 on non-python packages
+    from setuptools import find_namespace_packages
+except ImportError:
+    # python 2.7 has no find_namespace_packages
+    # but works fine with find_packages
+    from setuptools import find_packages as find_namespace_packages
+
 from setuptools import setup

@@ -18,6 +25,7 @@ setup(
     version="0.9.1.dev0",
     description="Collabora Online integration for Plone",
     long_description=long_description,
+    long_description_content_type="text/x-rst",
     # Get more from https://pypi.org/classifiers/
     classifiers=[
         "Development Status :: 4 - Beta",
@@ -50,7 +58,7 @@ setup(
         "Documentation": "https://collective.collabora.readthedocs.io/en/latest/",
     },
     license="GPL version 2",
-    packages=find_packages("src", exclude=["ez_setup"]),
+    packages=find_namespace_packages("src", exclude=["ez_setup"]),
     # keep deprecated namespace_packages for backward compatibility
     namespace_packages=["collective"],
     package_dir={"": "src"},
```


## Publishing the documentation

Putting all the documentation in `README.rst` turned out to be suboptimal.
It didn't properly render my architecture diagram.

Instead:
- `pip install sphinx` in my development environment
- `sphinx quickstart` to set up the sphinx configuration in `./docs/`
- Simplify the README, and put the long documentation in `./docs/`
- `sphinx build` to test the generated documentation
- I logged in on [read the docs](https://readsthedocs.com/) community platform with Github
- Add a project for the package
- Added [.readthedocs.yaml](https://github.com/collective/collective.collabora/blob/main/.readthedocs.yaml) to configure the ReadTheDocs integration
- `git push`

You can see the result on https://collectivecollabora.readthedocs.io/


## Conclusion and Summary

For this project, I created separate development environments for Quaive and Plone.
I then started with the vanilla Plone 6 implementation. In the course of developing that,
it became clear that the proof of concept code we had, could be generalized.
All that is needed on the Quaive side, is some UI integration code.

Using [Python-Future](https://python-future.org/) made it possible, to make this code backward-compatible for Plone 4.

The result is [a single codebase that supports Plone6, Plone5 and Plone4.](https://github.com/collective/collective.collabora/tree/main)
and powers the Quaive UI integration with minimal glue code.
