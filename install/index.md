---
layout: page
title: Installing veraPDF
---

Downloading the Installer
-------------------------
There are currently two versions of veraPDF:

- the veraPDF Greenfield implementation built around a bespoke PDF parser and
  PDF/A and PDF/UA validation models developed by the veraPDF team; and
- a version that uses [Apache PDFBox](https://pdfbox.apache.org/) as a PDF
  parser and to implement the PDF/A validation model.

It's possible to download the latest release and development builds for each
version. The release versions are stable and you should use these unless you're sure you want the development build and stability / reliability isn't important to you. The development builds aren't guaranteed to be stable and may contain unfinished features. You should use these if you're testing a bug fix or new feature.

This gives four possible downloads:

| Dowload | Greenfield Implementation | Apache PDFBox Implementation |
|----------------|-----------------------------------------------------------------------------------------------------------|
| Release Installer | <a href="http://downloads.verapdf.org/rel/verapdf-installer.zip"  onclick="ga('send', { hitType: 'event', eventCategory: 'gf-rel',  eventAction: 'download',  eventLabel: 'zip'});"><i class="fa fa-file-zip-o" aria-hidden="true"></i> The latest stable veraPDF zip package.</a> | <a href="http://downloads.verapdf.org/rel/verapdf-pdfbox-installer.zip"  onclick="ga('send', { hitType: 'event', eventCategory: 'pb-rel',  eventAction: 'download',  eventLabel: 'zip'});"><i class="fa fa-file-zip-o" aria-hidden="true"></i> The latest stable PDF Box zip package.</a> |
|  | <a href="http://downloads.verapdf.org/rel/verapdf-installer.zip.asc"  onclick="ga('send', { hitType: 'event', eventCategory: 'gf-rel',  eventAction: 'download',  eventLabel: 'gpg'});"><i class="fa fa-certificate" aria-hidden="true"></i> GPG signature.</a> | <a href="http://downloads.verapdf.org/rel/verapdf-pdfbox-installer.zip.asc"  onclick="ga('send', { hitType: 'event', eventCategory: 'pb-rel',  eventAction: 'download',  eventLabel: 'gpg'});"><i class="fa fa-certificate" aria-hidden="true"></i> GPG signature.</a> |
| Development Installer | <a href="http://downloads.verapdf.org/dev/verapdf-installer.zip"  onclick="ga('send', { hitType: 'event', eventCategory: 'gf-dev',  eventAction: 'download',  eventLabel: 'zip'});"><i class="fa fa-file-zip-o" aria-hidden="true"></i> Development veraPDF zip package.</a> | <a href="http://downloads.verapdf.org/dev/verapdf-pdfbox-installer.zip"  onclick="ga('send', { hitType: 'event', eventCategory: 'pb-dev',  eventAction: 'download',  eventLabel: 'zip'});"><i class="fa fa-file-zip-o" aria-hidden="true"></i> Development PDFBox zip</a> |
| | <a href="http://downloads.verapdf.org/dev/verapdf-installer.zip.asc"  onclick="ga('send', { hitType: 'event', eventCategory: 'gf-rel',  eventAction: 'download',  eventLabel: 'gpg'});"><i class="fa fa-certificate" aria-hidden="true"></i> GPG signature.</a> | <a href="http://downloads.verapdf.org/dev/verapdf-pdfbox-installer.zip.asc"  onclick="ga('send', { hitType: 'event', eventCategory: 'pb-dev',  eventAction: 'download',  eventLabel: 'gpg'});"><i class="fa fa-certificate" aria-hidden="true"></i> GPG signature.</a> |
{:.table }

### Verifying the installer download
If you want to verify your download for security and integrity then first download the GPG signature file into the same directory as the installer zip. You'll need a copy of our GPG key, you can get it [from our downloads site](http://downloads.verapdf.org/keys/KEY) or from a keyserver:
<kbd>gpg --keyserver pgp.mit.edu --recv 1C124847</kbd>. Once the key is imported you can use it to verify the zip archive with the signature, e.g.
<kbd>gpg --verify verapdf-pdfbox-installer.zip.asc</kbd>

What's in the installer?
------------------------
All versions of the installer are provided as a zip file that contains:

- the Java installer and application as a single jar file,
  `verapdf-izpack-installer-<version>.jar`;
- a Windows batch file that runs the installer, `vera-install.bat`;
- a bash script that executes the installer on Linux or Mac OS machines,
  `vera-install.sh`.

The installer jar file includes the application binary files and supplementary
resources, including:

- Validation Model description;
- test PDF Documents; and
- the veraPDF Validation Profiles.

Using the veraPDF installer
---------------------------
The installer simply unpacks components from the installer package to the local
computer. It consists of the five steps:

### 1: About veraPDF
The first tells you which version of the software you're installing:

![veraPDF Installer folder selection screen](/images/installer/screen1.png "veraPDF installer step 1 of 5"){: .img-responsive .center-block}

### 2: Choose installation location
At step two you can specify the installation folder:

![veraPDF Installer folder selection screen](/images/installer/screen2.png "veraPDF installer step 2 of 5"){: .img-responsive .center-block}

### <a name="step3"></a>3: Select components
Screen three allows you to select the components to be installed:

![veraPDF Installer pack selection screen](/images/installer/screen3.png "veraPDF installer step 3 of 5"){: .img-responsive .center-block}

### 4: Installation
The fourth stage installs the selected components to the chosen location:

![veraPDF Installer pack selection screen](/images/installer/screen4.png "veraPDF installer step 4 of 5"){: .img-responsive .center-block}

### 5: Generate installation script
It is possible to generate an installation script that can be used to repeat
the installation on another computer:

![veraPDF Installer script screen](/images/installer/screen5.png "veraPDF installer step 4 of 5"){: .img-responsive .center-block}

What's installed where?
-----------------------
Following installation test PDF Documents can be found in the ‘corpus’ subfolder
below the application installation folder, the Validation Model description is
located in the ‘model’ subfolder, while the Validation Profiles are located in
the ‘profiles’ subfolder.

The implementation of the veraPDF Command line application, Desktop GUI and
other software components are located in ‘bin’ subfolder.
