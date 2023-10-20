---
layout: page
title: veraPDF CLI Getting Help
---

Once veraPDF has been installed you can get help on the full range of options by
typing <kbd>verapdf -h</kbd> or <kbd>verapdf --help</kbd> at the Mac or Linux
command line. This should be <kbd>verapdf.bat -h</kbd> or
<kbd>verapdf.bat --help</kbd> on Windows (we won't keep reminding you of the alternative Windows syntax). This should give the following output, or
something very similar:

```bash
Usage: veraPDF [options] FILES
  Options:
      --addlogs
        Add logs to xml (mrr), json or html report.
        Default: false
      --config
        Sets settings from the config files, if no cli parameters are specified.
        Default: false
      -d, --debug
        Outputs all processed file names.
        Default: false
      -df, --defaultflavour
        Chooses built-in Validation Profile default flavour, e.g. '1b'. This 
        flavour will be applied if automatic flavour detection based on a file`s 
        metadata doesn`t work.
        Default: 1b
        Possible Values: [1a, 1b, 2a, 2b, 2u, 3a, 3b, 3u, 4, 4f, 4e, ua1]
      --disableerrormessages
        Disable detailed error messages in the validation report.
        Default: false
      -x, --extract
        Extracts and reports PDF features. Features must be passed separated by commas without spaces between them.
        Possible Values: [actions, annotations, colorSpace, ds, embeddedFile, exGSt, font, formXobject, iccProfile, imageXobject, informationDict, interactiveFormField, lowLevelInfo, metadata, outlines, outputIntent, page, pattern, postscriptXobject, properties, shading, signature, error]
      --fixmetadata
        Performs metadata fixes.
        Default: false
      -f, --flavour
        Chooses built-in Validation Profile flavour, e.g. '1b'. Alternatively, 
        supply '0' or no argument for automatic flavour detection based on a 
        file`s metadata.
        Default: 0
        Possible Values: [0, 1a, 1b, 2a, 2b, 2u, 3a, 3b, 3u, 4, 4f, 4e, ua1]
      --format
        Chooses output format.
        Default: xml
        Possible Values: [raw, xml, text, html, json]
      -h, --help
        Shows this message and exits.
      -l, --list
        Lists built-in Validation Profiles.
        Default: false
      --loglevel
        Enables logs with level: 0 - OFF, 1 - SEVERE, 2 - WARNING, SEVERE
        (default), 3 - CONFIG, INFO, WARNING, SEVERE, 4 - ALL.
        Default: 2 
      --maxfailures
        Sets maximum amount of failed checks.
        Default: -1
      --maxfailuresdisplayed
        Sets maximum amount of failed checks displayed for each rule. -1 for 
        unlimited number of failed checks.
        Default: 100
      --nonpdfext
        Select files without .pdf extension
        Default: false
      -o, --off
        Turns off validation
        Default: false
      --password
        Sets the password for an encrypted document.
      --policyfile
        Select a policy schematron or XSL file.
      --prefix
        Sets file name prefix for any fixed files.
        Default: veraFixMd_
      --processes
        The number of processes which will be used.
        Default: 1
      -p, --profile
        Loads a Validation Profile from given path and exits if loading fails. 
        This overrides any choice or default implied by the -f / --flavour 
        option. 
      -pw, --profilesWiki
        Sets location of the Validation Profiles wiki.
        Default: https://github.com/veraPDF/veraPDF-validation-profiles/wiki/
      --progress
        Shows the current status of the validation job.
        Default: false
      -r, --recurse
        Recurses through directories. Only files with .pdf extensions are 
        processed. 
        Default: false
      --savefolder
        Sets output directory for any fixed files.
        Default: <empty string>
      --success, --passed
        Logs successful validation checks.
        Default: false
      -v, --verbose
        Adds failed test information to text output.
        Default: false
      --version
        Displays veraPDF version information.
        Default: false
```
