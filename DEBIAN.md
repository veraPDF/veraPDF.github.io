Debian Packagaing
=================
Aims
----
Implement an automated build that creates debian packages for the veraPDF and
JHOVE command line applications. This should be demonstrated as:
- a build and install for the package working on a vanilla Debian Jessie
  `vagrant` VM;
- the same process building and installing on Travis-CI, Trusty Tahr; and
- a Jenkins job that publishes the package via a local apt repository.

### Package hierarchy
The apt package structure with mapping back to the veraPDF GitHub and Maven
projects. We wanted as simple a package hierarchy as possible that still
offered modularity via library jars. This allows the update or replacement of
individual components by the veraPDF development team, or third parties.

The veraPDF team will be replacing the current PDF Box parser with our own
parser implementation before the version 1.0 release in December 2016.

    verapdf
      - verapdf-core   : combines the model, xmp and library projects
      - verapdf-pdfbox : combines our PDF Box fork and pdfbox-validation projects,
                         depends on verapdf-core.
      - verapdf-apps   : CLI and GUI package, depends on verapdf-pdfbox

### Package Rules
We'll create user space programs for the GUI and CLI applications that depend
on a set of veraPDF Java librarys in a separate package. Below are the extracts
from the Debian Packaging and Java Packaging guides that seem most applicable:
- For user space applications there should be an executable jar with an
  accompanying wrapper script or symlink.
- The executable package MUST have an absoluted dependency on `jarwrapper` or
  an equivalent package so JARS are executable from `PATH`.
- Remember to set up Main Class properly and mark the manifest file
  appropriately.
- Library jars to go into `/usr/share/java` if intended for use by other
  programs or into a package private directory `/usr/share/<package>`.
- Libraries MUST NOT depend on a Java runtime.
- Library packages MUST be named `libXXX[version]-java` (without the brackets),
  version part only used to avoid naming clashes
- The classes for libraries MUST be in jar archives in the directory
  `/usr/share/java` with the name `packagename[-extraname]-fullversion.jar`.
  The extraname is used internally within packages that supply multiple jars.
  The fullversion is that of the jar file and is not necessarily the same as
  the package.

### Packaging workflow
We'll start by treating veraPDF as an upstream source and adopt a "typical"
Debian packaging workflow, see [Debian Maintainers Guide](https://www.debian.org/doc/manuals/maint-guide/first.en.html).

### Initial Package structure
Starting with the path of least resistance we'll produce a package per Maven
project using the `mh_make` tool. This is designed to produce the appropriate
Debian files/structure using the Maven POM files and leveraging Maven project
conventions.

### Package structure goals
This sections describes where we'd like to get to. We'll err on the side of
caution and add everything to a package specific library directory
`/usr/share/verapdf`. All examples use our current 0.14 version number.

#### verapdf-core
Source and binary library package that installs 3 jars to `/usr/share/verapdf`,
and symlinks as suggested by the guidelines:

    /usr
      /share
        /verapdf
          - verapdf-library-0.14.1.jar
          - verapdf-library.jar -> verapdf-library-0.14.1.jar
          - verapdf-xmp-0.11.1.jar
          - verapdf-xmp.jar -> verapdf-xmp-0.11.1.jar
          - verapdf-model-0.14.1.jar
          - verapdf-model.jar -> verapdf-model-0.14.1.jar
The package will also include source and JavaDoc but no other documentation.
#### verapdf-pdfbox
Source and binary library package that installs four jars to
`/usr/share/verapdf`, and symlinks as suggested by the guidelines:

    /usr
      /share
        /verapdf
          - verapdf-pdf-features-0.14.1.jar
          - verapdf-pdf-features.jar -> verapdf-pdf-features-0.14.1.jar
          - verapdf-pdf-model-0.14.1.jar
          - verapdf-pdf-model.jar -> verapdf-pdf-model-0.14.1.jar
          - verapdf-pdf-fixer-0.14.1.jar
          - verapdf-pdf-fixer.jar -> verapdf-pdf-fixer-0.14.1.jar
          - verapdf-pdfbox-2.0.0.jar
          - verapdf-pdfbox.jar -> verapdf-pdfbox-2.0.0.jar
The package will also include source and JavaDoc but no other documentation.

How To
-------
- [ ] Test vagrant process on Mavericks
- [ ] Test vagrant process on Windows 10
- [ ] Test vagrant process on Windows 7

The Debian packaging tasks will execute in a Debian environment, this should
also work using a Debian derivative e.g. Ubuntu or Mint. The development/test
environments are:
- a vanilla Debian Jessie VM;
- a local development workstation running `Ubuntu 16.04 LTS xenial`; and
- the Travis-CI Trusty beta.

### Vagrant environment
#### Pre-requisites
- Oracle VirtualBox
- Vagrant VM management tool

#### Setup Debian vagrant box
- [ ] This into the Vagrantfile provisioning

Here we describe the configuration of the vagrant packaging environment. We
begin with a vanilla Debian Jessie VirtualBox virtual machine. We use vagrant,
a command line client used to automate virtual machine management.

First create a directory, initialise vagrant VM, and start an SSH session:

    mkdir veraPDF-apt
    cd veraPDF-apt
    vagrant init boxcutter/debian82
    vagrant up --provider virtualbox
    vagrant ssh
Finally update Debian:

    sudo apt-get update
    sudo apt-get upgrade

### Setup - build environment
We presume that your now using a Debian based distro of your own or the
vagrant environment above.

We'll install the `maven-debian-helper` package, which brings
a LOT of other packages with it, and the `javahelper` package

    sudo apt-get install maven-debian-helper
    sudo apt-get install javahelper
    That's the tools to make Java packaging as painless as possible.
- [ ] Document

    sudo apt-get install apt-file
    sudo apt-get install git git-doc git-extras git-flow git-man git-sh
    cd /vagrant
    git clone https://github.com/veraPDF/veraPDF-library.git
    mh_make
    ......

Software
---------
### Build environment and automation
- Oracle VirtualBox - virtualization
- Vagrant - command line management of VirtualBox VMs
- Debian Jessie vagrant VM - vanilla Jessie with VirtualBox Addons

References
----------
1. [Debian Policy for Java](https://www.debian.org/doc/packaging-manuals/java-policy/index.html)
2. [Debian Wiki page on Java packaging](https://wiki.debian.org/Java/Packaging), currently under revision.
3. [Debian `javahelper` package](https://packages.debian.org/sid/javahelper)
4. [DebConf 10 Java Helper slides](http://pkg-java.alioth.debian.org/docs/debconf10-javahelper-slides.pdf) & [presentation video](http://caesar.acc.umu.se/pub/debian-meetings/2010/debconf10/high/1293_Packaging_with_javahelper.ogv)
5. [`MavenDebianHelper` package documentation](https://wiki.debian.org/Java/MavenDebianHelper)
6. [Packaging Java with Javatools](http://pkg-java.alioth.debian.org/docs/tutorial.html)
