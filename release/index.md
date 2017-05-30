---
layout: page
title: Semanitic versioning
---

## Introduction

### Audience
Anyone who's curious how we create our software version numbers.

### Pre-requisites
Reading this home page [Semantic Versioning](http://semver.org/) is a good idea.

## Versioning Policy

### Major version zero
We're currently developing `(0.y.z)` software, [Semantic Versioning](http://semver.org/) this to say:

    Major version zero `(0.y.z)` is for initial development.
    Anything may change at any time.
    The public API should not be considered stable.

We'll release the first `1.0.z` release candidate with all features and a stable API for December 2016.

### Minor significance
The veraPDF software projects use the `MINOR` version number to indicate the development status of a particular version. An even number signifies a release version while an odd numbers are assigned to development prototypes.  For example:

    x.0.z
    0.2.z
    1.44.15

would ALL be release versions, while:

    x.5.z
    0.3.z
    2.13.0

are all development versions.

### Patch for buld ID
The final `PATCH` number is automatically incremented by our [Jenkins build server](http://jenkins.openpreservation.org/job/veraPDF-library-dev/) ensuring that each official build is identifiable.
