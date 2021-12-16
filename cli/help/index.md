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
      -d, --debug
        Outputs all processed file names.
        Default: false
      -df, --defaultflavour
        Chooses built-in Validation Profile default flavour, e.g. '1b'. This 
        flavor will be applied if automatic flavour detection based on a file`s 
        metadata doesn`t work.
        Default: 1b
        Possible Values: [0, 1a, 1b, 2a, 2b, 2u, 3a, 3b, 3u, 4, 4f, 4e, ua1, wcag2]
      -x, --extract
        Extracts and reports PDF features.
        Default: false
      --fixmetadata
        Performs metadata fixes.
        Default: false
      -f, --flavour
        Chooses built-in Validation Profile flavour, e.g. '1b'. Alternatively, 
        supply '0' or no argument for automatic flavour detection based on a 
        file`s metadata.
        Default: 0
        Possible Values: [0, 1a, 1b, 2a, 2b, 2u, 3a, 3b, 3u, 4, ua1]
      --format
        Chooses output format.
        Default: mrr
        Possible Values: [xml, mrr, text]
      -h, --help
        Shows this message and exits.
      -l, --list
        Lists built-in Validation Profiles.
        Default: false
      --maxfailures
        Sets maximum amount of failed checks.
        Default: -1
      --maxfailuresdisplayed
        Sets maximum amount of failed checks displayed for each rule.
        Default: 100
      --nonpdfext
        Select files without .pdf extension
        Default: false
      -o, --off
        Turns off PDF/A validation
        Default: false
      --policyfile
        Select a policy schematron or XSL file.
      --prefix
        Sets file name prefix for any fixed files.
        Default: veraFixMd_
      --processes
        The Number of processes which will be used.
        Default: 1
      -p, --profile
        Loads a Validation Profile from given path and exits if loading fails. 
        This overrides any choice or default implied by the -f / --flavour 
        option. 
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
