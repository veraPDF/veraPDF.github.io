---
layout: page
title: veraPDF CLI Quick Start Guide
---

The veraPDF command line interface is the best way of processing batches of
PDF files. It's designed for integrating with scripted workflows, or for
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
available [on GitHub](https://github.com/veraPDF/veraPDF-corpus).

### Links to how-tos

- [Using veraPDF for PDF/A and PDF/UA Validation](validation):
  - [listing built in validation profiles](validation#list-profiles);
  - [validating using a built in profile](validation#choose-profile);
  - [validating using automated profile selection](validation#auto-profile);
  - [validating multiple conformance claims in one go](validation#multiple-profiles);
  - [defining validation report](validation#defining-validation-report);
  - [controlling console logs](validation#logs-customising)
  - [validating multiple files in the folder](validation#batches);
  - [validating PDFs from ZIP archives](validation#zip-archive-validation)
  - [optimizing the validation process](validation#customising);
- [Extracting features (metadata) from PDFs](feature-extraction):
  - [extracting Information Dictionary metadata](feature-extraction#info-dict);
  - [extracting XMP metadata](feature-extraction#metadata);
  - [extracting Font information](feature-extraction#fonts); and
  - [extracting image features](feature-extraction#images).
- [Enforcing institutional policy](/policy).
- [Fixing metadata](fixing).
