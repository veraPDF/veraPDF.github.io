---
layout: page
title: veraPDF CLI Validation
---

## Choosing the right validation profile
----------------------------------------------------------------

### <a name="list-profiles"></a>Listing built in validation profiles
The veraPDF software comes with predefined sets of rules covering PDF/A and PDF/UA standards. These are known
as validation profiles and there's one for each level and part of the PDF/A and PDF/UA
specification. You can list them by typing <kbd>verapdf -l</kbd> or <kbd>verapdf.bat --list</kbd> for Windows users. The `-l` and `--list` are interchangeable on all platforms.
You'll be greeted with:

```bash
veraPDF supported PDF/A and PDF/UA profiles:
  1a - PDF/A-1A validation profile
  1b - PDF/A-1B validation profile
  2a - PDF/A-2A validation profile
  2b - PDF/A-2B validation profile
  2u - PDF/A-2U validation profile
  3a - PDF/A-3A validation profile
  3b - PDF/A-3B validation profile
  3u - PDF/A-3U validation profile
  4 - PDF/A-4 validation profile
  4e - PDF/A-4E validation profile
  4f - PDF/A-4F validation profile
  ua1 - PDF/UA-1 validation profile
  ua2 - PDF/UA-2 validation profile
```

### <a name="choose-profile"></a>Choosing a built-in profile
You can specify a built in profile for validation using either the `-f` or `--flavour` options followed by the 2 character profile code. 
For example, to validate a single PDF/A file from the corpus using the PDF/A-1B profile type

<kbd>verapdf -f 1b corpus/veraPDF-corpus-staging/PDF_A-1b/6.6\ Actions/6.6.1\ General/veraPDF\ test\ suite\ 6-6-1-t02-pass-a.pdf</kbd>

You should see something very similar to the following output:

```xml
<?xml version="1.0" encoding="utf-8"?>
  <report>
    <buildInformation>
      <releaseDetails id="core" version="{{ site.verapdf_version_number }}" buildDate="2023-01-10T02:34:00Z"></releaseDetails>
      <releaseDetails id="gui" version="{{ site.verapdf_version_number }}" buildDate="2023-01-13T11:30:00Z"></releaseDetails>
      <releaseDetails id="validation-model" version="{{ site.verapdf_version_number }}" buildDate="2023-01-10T02:39:00Z"></releaseDetails>
    </buildInformation>
    <jobs>
      <job>
        <item size="10230">
          <name>/home/cfw/verapdf/dev/corpus/veraPDF-corpus-staging/PDF_A-1b/6.6 Actions/6.6.1 General/veraPDF test suite 6-6-1-t02-pass-a.pdf</name>
        </item>
        <validationReport profileName="PDF/A-1B validation profile" statement="PDF file is compliant with Validation Profile requirements." isCompliant="true">
            <details passedRules="102" failedRules="0" passedChecks="504" failedChecks="0"></details>
        </validationReport>
        <duration start="1485134290404" finish="1485134290797">00:00:00:393</duration>
      </job>
    </jobs>
    <batchSummary totalJobs="1" failedToParse="0" encrypted="0" outOfMemory="0" veraExceptions="0">
      <validationReports compliant="1" nonCompliant="0" failedJobs="0">1</validationReports>
      <featureReports failedJobs="0">0</featureReports>
      <repairReports failedJobs="0">0</repairReports>
      <duration start="1485134290384" finish="1485134290846">00:00:00:462</duration>
  </batchSummary>
</report>
```

This tells us that the file is valid through the `<validationReport isCompliant="true">` attribute.

### <a name="auto-profile"></a>Letting veraPDF control the profile choice
Specifying a particular profile is useful if you're expecting all of your PDF/A or PDF/UA
documents to conform to a particular specification. In real word use you may
not have the luxury of been able to decide on a single validation profile.

It's possible to tell the veraPDF software to parse PDF files, examine the
metadata and select the appropriate PDF/A or PDF/UA profile for validation. This is
requested by specifying the special `-f 0` or `--flavour 0` option, or passing
no flavour option at all. There's an invalid PDF/A file in the same corpus directory. you can validate it by typing:

<kbd>verapdf -f 0 corpus/veraPDF-corpus-staging/PDF_A-1b/6.6\ Actions/6.6.1\ General/veraPDF\ test\ suite\ 6-6-1-t0
veraPDF test suite 6-6-1-t01-fail-a.pdf  veraPDF test suite 6-6-1-t02-pass-a.pdf</kbd>

or even

<kbd>verapdf corpus/veraPDF-corpus-staging/PDF_A-1b/6.6\ Actions/6.6.1\ General/veraPDF\ test\ suite\ 6-6-1-t0
veraPDF test suite 6-6-1-t01-fail-a.pdf</kbd>.

This time the output looks like:

```xml
<?xml version="1.0" encoding="utf-8"?>
  <report>
    <buildInformation>
      <releaseDetails id="core" version="{{ site.verapdf_version_number }}" buildDate="2023-01-10T02:34:00Z"></releaseDetails>
      <releaseDetails id="gui" version="{{ site.verapdf_version_number }}" buildDate="2023-01-13T11:30:00Z"></releaseDetails>
      <releaseDetails id="validation-model" version="{{ site.verapdf_version_number }}" buildDate="2023-01-10T02:39:00Z"></releaseDetails>
    </buildInformation>
    <jobs>
      <job>
        <item size="6213">
          <name>/home/cfw/verapdf/dev/corpus/veraPDF-corpus-staging/PDF_A-1b/6.6 Actions/6.6.1 General/veraPDF test suite 6-6-1-t01-fail-a.pdf</name>
        </item>
        <validationReport profileName="PDF/A-1B validation profile" statement="PDF file is not compliant with Validation Profile requirements." isCompliant="false">
          <details passedRules="101" failedRules="1" passedChecks="358" failedChecks="1">
            <rule specification="ISO 19005-1:2005" clause="6.6.1" testNumber="1" status="failed" passedChecks="0" failedChecks="1">
              <description>The Launch, Sound, Movie, ResetForm, ImportData and JavaScript actions shall not be permitted.
                Additionally, the deprecated set-state and no-op actions shall not be permitted. The Hide action shall not be permitted (Corrigendum 2)</description>
              <object>PDAction</object>
              <test>S == "GoTo" || S == "GoToR" || S == "Thread" || S == "URI" || S == "Named" || S == "SubmitForm"</test>
              <check status="failed">
                <context>root/document[0]/OpenAction[0](5 0 obj PDAction)</context>
              </check>
            </rule>
          </details>
        </validationReport>
        <duration start="1485163106779" finish="1485163107279">00:00:00:500</duration>
      </job>
    </jobs>
    <batchSummary totalJobs="1" failedToParse="0" encrypted="0" outOfMemory="0" veraExceptions="0">
      <validationReports compliant="0" nonCompliant="1" failedJobs="0">1</validationReports>
      <featureReports failedJobs="0">0</featureReports>
      <repairReports failedJobs="0">0</repairReports>
      <duration start="1485163106741" finish="1485163107379">00:00:00:638</duration>
  </batchSummary>
</report>
```

This time the report tells us that the file is invalid through the `<validationReport isCompliant="false">` attribute. It also shows the details
of the failed test.

### <a name="default-flavour"></a>Default flavour
Automatic flavour detection is based on the document conformance specified in the embedded XMP metadata. If this metadata is not available or invalid, the default validation flavour is applied.
It is PDF/A-1b by default, but the user can change it by using `--defaultflavour` or `-df` option, for example

<kbd>verapdf --defaultflavour 2b test.pdf</kbd>

### <a name="custom-profile"></a>Choosing custom profile
The user can validate PDF files against a custom validation profile by using option `--profile` or `-p`. For example

<kbd>verapdf --profile profile.xml test.pdf</kbd>

## <a name="defining-validation-report"></a>Defining validation report
----------------------------------------------------------------

### Report format
By default, veraPDF generates report in xml format. The user can specify a different report format (`text`, `raw`, `html`, `json`) by using `--format` option with argument `text`, `raw`, `html` or `json` accordingly.

Note. Before veraPDF release 1.24 `raw` report was called `xml`. Starting from veraPDF release 1.24 `xml` and `mrr` refer to the same report format, and `mrr` report format is deprecated.

### Don't display all failed checks for a particular rule
Sometimes files fail validation checks many times for a particular
validation rule. This is particularly true for rules relating to fonts and
colour profiles. You can use the `--maxfailuresdisplayed` option to control the
maximum number of failures reported for a particular rule.

The veraPDF software will continue to process all checks without terminating, it
just won't report all the results for every rule. The default is to report one
hundred failed checks per rule. To change the limit to 10 add the `--maxfailuresdisplayed 10` option.

### Report successful checks as well as failures
By default veraPDF only reports failed checks. It is possible to report passed
checks by adding the `--success` or `--passed` option to the CLI. In order to
see the passed checks for one of the test files type:

<kbd>verapdf --success corpus/veraPDF-corpus-staging/PDF_A-1b/6.6\ Actions/6.6.1\ General/veraPDF\ test\ suite\ 6-6-1-t02-pass-a.pdf</kbd>

We won't show the output here as it's quite long. The lack of any `-f` or
`--flavour` option means that veraPDF will select the appropriate Validation
Profile, meaning it's equivalent to `-f 0` or `--flavour 0`,
[see automatic profile selection above](#auto-profile).

### <a name="logs-customising"></a>Include console logs into the report
veraPDF CLI generates log messages into the standard error (`stderr`) output. By default they will go into the same console output as the generated report and may corrupt it. To redirect these log messages to a file (for example, `logs.txt`), use the command `verapdf 2>logs.txt ...`.  

The user can also include logs into the report by using option `--addlogs`. 

The level of displayed logs is specified in option `--loglevel`. Available levels are: 
- 0 - OFF, 
- 1 - SEVERE, 
- 2 - WARNING, SEVERE
- 3 - CONFIG, INFO, WARNING, SEVERE, 
- 4 - ALL.

### <a name="wiki-path"></a>Profiles wiki
HTML report contains reference links to veraPDF validation rule wiki https://github.com/veraPDF/veraPDF-validation-profiles/wiki/. You are unlikely going to change this unless you intend to host your own local version of the veraPDF validation rule wiki by using `--wikiPath` option.

### Show validation errors in text report
Text report contains only failed rule numbers. If the numbers of passed rules are needed, `--verbose` or `-v` should be used.

## <a name="batches"></a>Processing multiple PDF files
---------------------------------------------------

### Process all PDF files in the folder
So far we've only validated single PDF/A documents. It's easy to validate
multiple PDF documents using the command line interface. You can do this by
passing the name of a directory rather than a file. To validate both of the
earlier examples in a single command type:

<kbd>verapdf corpus/veraPDF-corpus-staging/PDF_A-1b/6.6\ Actions/6.6.1\ General/</kbd>

You can also validate any files in sub-directories by passing the `-r` or
`--recurse` flag. If you want to validate all PDF files in the corpus directory
type:

<kbd>verapdf --recurse corpus</kbd>

This obviously generates a lot of output and takes a little time to run, the
batch summary on the test machine is shown below for reference:

```xml
<batchSummary totalJobs="1526" failedToParse="0" encrypted="0" outOfMemory="0" veraExceptions="0">
  <validationReports compliant="636" nonCompliant="890" failedJobs="0">1526</validationReports>
  <featureReports failedJobs="0">0</featureReports>
  <repairReports failedJobs="0">0</repairReports>
  <duration start="1485171727902" finish="1485171827790">00:01:39:888</duration>
</batchSummary>
```

meaning the software took one minute and forty seconds to process one thousand
and five hundred files.

### <a name="zip-archive-validation"></a>ZIP archive validation
It is also possible to validate multiple PDF documents within a ZIP archive. If an input file has ZIP format, veraPDF recursively scans and validates PDF files in all subfolders within the archive. For example

<kbd>verapdf test.zip</kbd>

### <a name="extension"></a>Non pdf extension
You can validate pdf files with non-pdf extension by passing the `--nonpdfext` option. For example
<kbd>verapdf somefile --nonpdfext</kbd>.

### <a name="show-file-names"></a>Show file names
While doing batch processing you may see all processed file names in console by using option `--debug` or `-d`.


## <a name="customising"></a>Optimizing validation processing
-------------------------------------------------------------------------

The test documents are deliberately quite small and there aren't too many checks
made during validation, five hundred or less in each case. Large PDF documents
can mean that the software makes hundreds of thousands of tests, sometimes with
thousands of failed checks. It's possible to control various aspects of this
process by using some of the CLI options.

### Stop processing after a set number of failures
The `--maxfailures` option tells veraPDF to halt processing after it encounters
a set number of failed checks, e.g `--maxfailures 10` would mean stop after 10
failed checks. The default value is -1, meaning process all failures.

### Disable error messages
By default, veraPDF contains detailed error messages for each error case in report. The user can disable these messages to speed up the validation by using option `--disableerrormessages`.

### Show progress
The user can see the current status of the validation job in console by using option `--progress`.

### Use several CPU processes in parallel
veraPDF can parallelize validation of multiple files in several processes. The number of processes can be specified by `--processes` option (1 by default). Independent of the number of processes used a single report for the while batch job will be generated.


## Other topics
----------------------------------------------------------------

### <a name="disable"></a>Disabling validation
As demonstrated in the examples above veraPDF validation runs as a default
option. While convenient this is not always desirable. You can disable
validation by passing the `-o` or `--off` option. This is usually done during
[feature-extraction](../feature-extraction), for example
<kbd>verapdf --off --extract somefile.pdf</kbd>.

### <a name="encrypted-pdf"></a>Encrypted PDF
By default, verapdf is trying to decrypt encrypted PDF file using empty user password. You can validate encrypted pdf  files with non-empty password by passing the `--password` option. 
For example <kbd>verapdf --password "12345" encrypted.pdf</kbd>.

### Using config files in CLI
veraPDF CLI can reuse configuration files of GUI application by specifying `--config` option. The set of configuration XML files is described in https://docs.verapdf.org/cli/config/. Note that any explicitly specified CLI parameters will override the corresponding parameters from the config files.
