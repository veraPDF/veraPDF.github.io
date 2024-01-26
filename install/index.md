---
layout: page
title: Installing veraPDF
---

## Downloading the Installer

There are currently two versions of veraPDF:

- the veraPDF Greenfield implementation built around a bespoke PDF parser and
  PDF/A and PDF/UA validation models developed by the veraPDF team; and
- a version that uses [Apache PDFBox](https://pdfbox.apache.org/) as a PDF
  parser and to implement the PDF/A validation model.

It's possible to download the latest release and development builds for each
version. The release versions are stable and you should use these unless you're sure you want the development build and stability/reliability isn't important to you. The development builds aren't guaranteed to be stable and may contain unfinished features. You should use these if you're testing a bug fix or new feature.

This gives four possible downloads:

| Download | Greenfield Implementation | Apache PDFBox Implementation |
|----------------|-----------------------------------------------------------------------------------------------------------|
| Release Installer | <a href="https://software.verapdf.org/releases/verapdf-installer.zip"  onclick="ga('send', { hitType: 'event', eventCategory: 'gf-rel',  eventAction: 'download',  eventLabel: 'zip'});"><i class="fa fa-file-zip-o" aria-hidden="true"></i> The latest stable veraPDF zip package.</a> | <a href="https://software.verapdf.org/releases/verapdf-pdfbox-installer.zip"  onclick="ga('send', { hitType: 'event', eventCategory: 'pb-rel',  eventAction: 'download',  eventLabel: 'zip'});"><i class="fa fa-file-zip-o" aria-hidden="true"></i> The latest stable PDF Box zip package.</a> |
|  | <a href="https://software.verapdf.org/releases/verapdf-installer.zip.asc"  onclick="ga('send', { hitType: 'event', eventCategory: 'gf-rel',  eventAction: 'download',  eventLabel: 'gpg'});"><i class="fa fa-certificate" aria-hidden="true"></i> GPG signature.</a> | <a href="https://software.verapdf.org/releases/verapdf-pdfbox-installer.zip.asc"  onclick="ga('send', { hitType: 'event', eventCategory: 'pb-rel',  eventAction: 'download',  eventLabel: 'gpg'});"><i class="fa fa-certificate" aria-hidden="true"></i> GPG signature.</a> |
| Development Installer | <a href="https://software.verapdf.org/develop/verapdf-installer.zip"  onclick="ga('send', { hitType: 'event', eventCategory: 'gf-dev',  eventAction: 'download',  eventLabel: 'zip'});"><i class="fa fa-file-zip-o" aria-hidden="true"></i> Development veraPDF zip package.</a> | <a href="https://software.verapdf.org/develop/verapdf-pdfbox-installer.zip"  onclick="ga('send', { hitType: 'event', eventCategory: 'pb-dev',  eventAction: 'download',  eventLabel: 'zip'});"><i class="fa fa-file-zip-o" aria-hidden="true"></i> Development PDFBox zip</a> |
| | <a href="https://software.verapdf.org/develop/verapdf-installer.zip.asc"  onclick="ga('send', { hitType: 'event', eventCategory: 'gf-rel',  eventAction: 'download',  eventLabel: 'gpg'});"><i class="fa fa-certificate" aria-hidden="true"></i> GPG signature.</a> | <a href="https://software.verapdf.org/develop/verapdf-pdfbox-installer.zip.asc"  onclick="ga('send', { hitType: 'event', eventCategory: 'pb-dev',  eventAction: 'download',  eventLabel: 'gpg'});"><i class="fa fa-certificate" aria-hidden="true"></i> GPG signature.</a> |
{:.table }

### Verifying the installer download

If you want to verify your download for security and integrity then first download the GPG signature file into the same directory as the installer zip. You'll need a copy of our GPG key. You can get it [from our downloads site](https://software.verapdf.org/keys/KEY) or from a keyserver:
<kbd>gpg --keyserver keyserver.ubuntu.com --recv 78B17FE7</kbd>. Once the key is imported you can use it to verify the zip archive with the signature, e.g. <kbd>gpg --verify verapdf-installer.zip.asc</kbd>.The public key fingerprint is `13DD 102B 4DD6 9354 D12D E5A8 3184 8632 78B1 7FE7`.

## What's in the installer?

All versions of the installer are provided as a zip file that contains:

- the Java installer and application as a single jar file,
  `verapdf-izpack-installer-<version>.jar`;
- a Windows batch file that runs the installer, `vera-install.bat`;
- a bash script that executes the installer on Linux or Mac OS machines,
  `vera-install`.

The installer jar file includes the application binary files and supplementary
resources, including:

- Validation Model description;
- test PDF Documents; and
- the veraPDF Validation Profiles.

## Using the veraPDF installer

The installer simply unpacks components from the installer package to the local
computer. It consists of five steps:

### 1: About veraPDF

The first tells you which version of the software you're installing:

![veraPDF Installer folder selection screen](/images/installer/screen1.png "veraPDF installer step 1 of 5"){: .img-responsive .center-block}

### 2: Choose installation location

At step two, you can specify the installation folder:

![veraPDF Installer folder selection screen](/images/installer/screen2.png "veraPDF installer step 2 of 5"){: .img-responsive .center-block}

### <a name="step3"></a>3: Select components

Screen three allows you to select the components to be installed:

![veraPDF Installer pack selection screen](/images/installer/screen3.png "veraPDF installer step 3 of 5"){: .img-responsive .center-block}

### 4: Installation

The fourth stage installs the selected components to the chosen location:

![veraPDF Installer pack selection screen](/images/installer/screen4.png "veraPDF installer step 4 of 5"){: .img-responsive .center-block}

### 5: Generate installation script

It is possible to generate an installation script that can be used to repeat
the installation on another computer, see [Automated installation](#autoinstall) below:

![veraPDF Installer script screen](/images/installer/screen5.png "veraPDF installer step 4 of 5"){: .img-responsive .center-block}

## What's installed where?

Following installation, test PDF Documents can be found in the ‘corpus’ subfolder
below the application installation folder, the Validation Model description is
located in the ‘model’ subfolder, while the Validation Profiles are located in
the ‘profiles’ subfolder.

The implementation of the veraPDF Command line application, Desktop GUI and
other software components are located in ‘bin’ subfolder.

<a id="autoinstall" name="autoinstall"/>

## Automated installation

The installer can be run in unattended mode from the command line, or script using the installation file generated by the installer.
The generated file isn't a script, but is simply an XML file that contains the configuration options you selected in the installer.
A typical example is shown below:

```xml
<AutomatedInstallation langpack="eng">
    <com.izforge.izpack.panels.htmlhello.HTMLHelloPanel id="welcome"/>
    <com.izforge.izpack.panels.target.TargetPanel id="install_dir">
        <installpath>/tmp/verapdf-test</installpath>
    </com.izforge.izpack.panels.target.TargetPanel>
    <com.izforge.izpack.panels.packs.PacksPanel id="sdk_pack_select">
        <pack index="0" name="veraPDF GUI" selected="true"/>
        <pack index="1" name="veraPDF Mac and *nix Scripts" selected="true"/>
        <pack index="2" name="veraPDF Validation model" selected="false"/>
        <pack index="3" name="veraPDF Documentation" selected="true"/>
        <pack index="4" name="veraPDF Sample Plugins" selected="false"/>
    </com.izforge.izpack.panels.packs.PacksPanel>
    <com.izforge.izpack.panels.install.InstallPanel id="install"/>
    <com.izforge.izpack.panels.finish.FinishPanel id="finish"/>
</AutomatedInstallation>
```

The above configuration will install the CLI, GUI, startup scripts and documentation to the `/tmp/verapdf-test` directory.
To invoke the installer from the command line with the an XML config file called `auto-install.xml` in the current directory, use the following command. Windows users should use `vera-install.bat` instead of `vera-install`:

```bash
./verapdf-install ./auto-install.xml
```

Typical output looks as follows:

```bash
Command line arguments: auto-install.xml 
[ Starting automated installation ]
====================
Installation started
Framework: 5.1.3-84aaf (IzPack)
Platform: linux,version=6.1.27-gentoo-r1-x86_64,arch=x64,symbolicName=null,javaVersion=17.0.8.1
[ Starting to unpack ]
[ Processing package: veraPDF GUI (1/3) ]
Cleaning up the target folder ...
[ Processing package: veraPDF Mac and *nix Scripts (2/3) ]
Cleaning up the target folder ...
[ Processing package: veraPDF Documentation (3/3) ]
Cleaning up the target folder ...
[ Unpacking finished ]
Installation finished
[ Writing the uninstaller data ... ]
[ Automated installation done ]
```

Further details regarding installation options can be found on the [IzPack Wiki page](https://izpack.atlassian.net/wiki/spaces/IZPACK/pages/42663940/Installation+Modes).
