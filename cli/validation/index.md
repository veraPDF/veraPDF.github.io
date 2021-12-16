---
layout: page
title: veraPDF CLI Validation
---

<a name="list-profiles"></a>Listing built in validation profiles
----------------------------------------------------------------
The veraPDF software comes with eight sets of rules built in. These are known
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
```

<a name="fixed-profiles"></a>Validation using built in profiles
-------------------------------------------------
You can specify a built in profile for validation using either the `-f` or
`--flavour` options followed by the 2 character profile code.

### <a name="choose-profile"></a>Choosing a PDF/A profile
To validate a single PDF/A file from the corpus using the PDF/A-1B profile type

<kbd>verapdf -f 1b corpus/veraPDF-corpus-staging/PDF_A-1b/6.6\ Actions/6.6.1\ General/veraPDF\ test\ suite\ 6-6-1-t02-pass-a.pdf</kbd>

You should see something very similar too the following output:

```xml
<?xml version="1.0" encoding="utf-8"?>
  <report>
    <buildInformation>
      <releaseDetails id="core" version="{{ site.verapdf_version_number }}" buildDate="2017-01-10T02:34:00Z"></releaseDetails>
      <releaseDetails id="gui" version="{{ site.verapdf_version_number }}-PDFBOX" buildDate="2017-01-13T11:30:00Z"></releaseDetails>
      <releaseDetails id="pdfbox-validation-model" version="{{ site.verapdf_version_number }}" buildDate="2017-01-10T02:39:00Z"></releaseDetails>
    </buildInformation>

    <jobs>
      <job>
        <item size="10230">
          <name>/home/cfw/verapdf/dev/corpus/veraPDF-corpus-staging/PDF_A-1b/6.6 Actions/6.6.1 General/veraPDF test suite 6-6-1-t02-pass-a.pdf</name>
          </item>
          <validationReport profileName="PDF/A-1B validation profile" statement="PDF file is compliant with Validation Profile requirements." isCompliant="true">
            <details passedRules="102" failedRules="0" passedChecks="504" failedChecks="0"></details>
        </validationReport>
        <processingTime>00:00:00:393</processingTime>
      </job>
    </jobs>
  <summary jobs="1" failedJobs="0" valid="1" inValid="0" validExcep="0" features="0">
    <duration start="1485134290384" finish="1485134290846">00:00:00:462</duration>
  </summary>
</report>
```

This tells us that the file is valid through the `<validationReport isCompliant="true">` attribute.

### <a name="auto-profile"></a>Letting veraPDF control the profile choice
Specifying a particular profile is useful if you're expecting all of your PDF/A
documents to conform to a particular specification. In real word use you may
not have the luxury of been able to decide on a single validation profile.

It's possible to tell the veraPDF software to parse PDF files, examine the
metadata and select the appropriate PDF/A profile for valdition. This is
requested by specifying the special `-f 0` or `--flavour 0` option, or passing
no flavour option at all. There's an invalid PDF/A file in the same corpus directory. you can validate it by typing:

<kbd>verapdf -f 0 corpus/veraPDF-corpus-staging/PDF_A-1b/6.6\ Actions/6.6.1\ General/veraPDF\ test\ suite\ 6-6-1-t0
veraPDF test suite 6-6-1-t01-fail-a.pdf  veraPDF test suite 6-6-1-t02-pass-a.pdf</kbd>

or even

<kbd>verapdf corpus/veraPDF-corpus-staging/PDF_A-1b/6.6\ Actions/6.6.1\ General/veraPDF\ test\ suite\ 6-6-1-t0
veraPDF test suite 6-6-1-t01-fail-a.pdf</kbd>.

This time the ouput looks like:

```xml
<?xml version="1.0" encoding="utf-8"?>
  <report>
    <buildInformation>
      <releaseDetails id="core" version="{{ site.verapdf_version_number }}" buildDate="2017-01-10T02:34:00Z"></releaseDetails>
      <releaseDetails id="gui" version="{{ site.verapdf_version_number }}-PDFBOX" buildDate="2017-01-13T11:30:00Z"></releaseDetails>
      <releaseDetails id="pdfbox-validation-model" version="{{ site.verapdf_version_number }}" buildDate="2017-01-10T02:39:00Z"></releaseDetails>
    </buildInformation>

    <jobs>
      <job>
        <item size="6213">
          <name>/home/cfw/verapdf/dev/corpus/veraPDF-corpus-staging/PDF_A-1b/6.6 Actions/6.6.1 General/veraPDF test suite 6-6-1-t01-fail-a.pdf</name>
        </item>
        <validationReport profileName="PDF/A-1B validation profile" statement="PDF file is not compliant with Validation Profile requirements." isCompliant="false">
          <details passedRules="101" failedRules="1" passedChecks="358" failedChecks="1">
            <rule specification="ISO 19005-1:2005" clause="6.6.1" testNumber="1" status="failed" passedChecks="0" failedChecks="1">
              <description>
                The Launch, Sound, Movie, ResetForm, ImportData and JavaScript actions shall not be permitted.
                Additionally, the deprecated set-state and no-op actions shall not be permitted. The Hide action shall not be permitted (Corrigendum 2)
              </description>
              <object>PDAction</object>
              <test>S == "GoTo" || S == "GoToR" || S == "Thread" || S == "URI" || S == "Named" || S == "SubmitForm"</test>
              <check status="failed">
                <context>root/document[0]/OpenAction[0](5 0 obj PDAction)</context>
              </check>
            </rule>
          </details>
        </validationReport>
        <processingTime>00:00:00:500</processingTime>
      </job>
    </jobs>
  <summary jobs="1" failedJobs="0" valid="0" inValid="1" validExcep="0" features="0">
    <duration start="1485163106741" finish="1485163107379">00:00:00:638</duration>
  </summary>
</report>
```

This time the report tells us that the file is invalid through the `<validationReport isCompliant="false">` attribute. It also shows the details
of the failed test.

<a name="customising"></a>Customising validation processing and reporting
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

### Don't display all failed checks for a particular rule
Sometimes PDF/A files fail validation checks many times for a particular
validation rule. This is particularly true for rules relating to fonts and
colour profiles. You can use the `--maxfailuresdisplayed` option to control the
maximum number of failures reported for a particular rule.

The veraPDF software will continue to process all checks without terminating, it
just won't report all the results for every rule. The default is to report one
hundred failed checks per-rule. To change the limit to 10 add the `--maxfailuresdisplayed 10` option.

### Log successful checks as well as failures
By default veraPDF only reports failed checks. It is possible to report passed
checks by adding the `--success` or `--passed` option to the CLI. In order to
see the passed checks for one of the test files type:

<kbd>verapdf --success corpus/veraPDF-corpus-staging/PDF_A-1b/6.6\ Actions/6.6.1\ General/veraPDF\ test\ suite\ 6-6-1-t02-pass-a.pdf</kbd>

We won't show the output here as it's quite long. The lack of any `-f` or
`--flavour` option means that veraPDF will select the appropriate Validation
Profile, meaning it's equivalent to `-f 0` or `--flavour 0`,
[see automatic profile selection above](#auto-profile).

<a name="batches"></a>Processing multiple PDF files
---------------------------------------------------
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
<summary jobs="1526" failedJobs="0" valid="636" inValid="890" validExcep="1" features="0">
  <duration start="1485171727902" finish="1485171827790">00:01:39:888</duration>
</summary>
```

meaning the software took one minute and forty seconds to process one thousand
and five hundred files.

<a name="disable"></a>Disabling PDF/A validation
------------------------------------------------
As demonstrated in the examples above veraPDF validation runs as a default
option. While convenient this is not always desirable. You can disable
validation by passing the `-o` or `--off` option. This is usually done during
[feature-extraction](../feature-extraction), for example
<kbd>verapdf --off --extract somefile.pdf</kbd>.
