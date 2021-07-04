---
layout: page
title: veraPDF CLI Quick Start Guide
---

The veraPDF command line interface is the best way of processing batches of
PDF/A files. It's designed for integrating with scripted workflows, or for
shell invocation from programs.

We assume you've already downloaded and installed the software, if not please
read the [installation guide](/install) first.

Using the terminal
------------------
We've provided a quick primer on setting up and using the terminal on our
supported platforms [here](terminal).

Getting help
------------
You can get the software to output its built in CLI usage message by typing
<kbd>verapdf.bat -h</kbd> or <kbd>verapdf --help</kbd>, an online version is [available here](help).

Configuring veraPDF
-------------------
veraPDF is controlled by a set of configuration files, you can read a [brief
overview here](config).

How-tos
-------
The following examples all make use of the veraPDF test corpus. This is
available [on GitHub](https://github.com/veraPDF/veraPDF-corpus). It is also
installed with the veraPDF software if you enable it
[at step 3](/install#step3). The test corpus will be installed in a
sub-directory called `corpus`. The examples assume your terminal session
is running in the installation directory with a suitable alias set up to avoid
typing <kbd>path-to-verapdf/verapdf</kbd>. On a Mac or Linux box this can be set up by typing <kbd>export verapdf='export verapdf='path-to-verapdf/verapdf'</kbd> at the command line.

### Links to how-tos

- [Using veraPDF for PDF/A and PDF/UA Validation](validation):
  - [listing built in validation profiles](validation#list-profiles);
  - [validating using a built in profile](validation#fixed-profiles);
  - [validating using automated profile selection](validation#auto-profile);
  - [customising the validation process and reporting](validation#customising); and
  - [validating mulitple files](validation#batches).
- [Extracting features (metadata) from PDFs](feature-extraction):
  - [extracting Information Dictionary metadtata](feature-extraction#info-dict);
  - [extracting XMP metadtata](feature-extraction#metadata);
  - [extracting Font information](feature-extraction#fonts); and
  - [extracting image features](feature-extraction#images).
- [Enforcing institutional policy](/policy).
- [Fixing PDF/A metadata](fixing).
