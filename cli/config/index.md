---
layout: page
title: veraPDF CLI Configuration
---

Introduction
------------

Below the veraPDF installation directory there is a sub-directory called
`config`. This contains the XML configuration files for the veraPDF software
components. To see the contents of this directory from a terminal session
in the installation root directory type <kbd>ls config/</kbd> on Mac or Linux
machines or <kbd>dir config</kbd> on Windows machines. On my Windows test VM
this outputs the following:

```
C:\Users\cfw\verapdf>dir config
 Volume in drive C has no label.
 Volume Serial Number is 1C45-2074

 Directory of C:\Users\cfw\verapdf\config

22/01/2017  12:44    <DIR>          .
22/01/2017  12:44    <DIR>          ..
22/01/2017  12:44               411 app.xml
22/01/2017  12:44               186 features.xml
22/01/2017  12:44               109 fixer.xml
22/01/2017  12:44               131 validator.xml
               4 File(s)            837 bytes
               2 Dir(s)   3,695,038,464 bytes free
```

If you can't see any files then it's likely you've not run the application after
installation. The software generates default configuration files on start-up if
none exist. Try running <kbd>verapdf --version</kbd> which should generate the
missing files.

### Running veraPDF without installation gives no configuration files
All of the aboive assumes that you've installed veraPDF with the downloaded
installer. If you're running a version of the application you've built
yourself and not installed you won't have an application home directory. The
following only applies if you're running a jar directly from the command line,
that is something like : <kbd>java -jar target/{{ site.verapdf_version_number }}.jar</kbd>, from the [`veraPDF-apps/gui` module](https://github.com/veraPDF/veraPDF-apps/tree/integration/gui).
The problem is that the installer adds a couple of invocation scripts that set
up the application home directory. The solution is to choose a config directory
and pass it to the application when you call it. Here's an example:

1. Select a folder you want to use as home and create it, a good suggestion is `~/.verapdf` beneath your home directory, in my case `/home/cfw/.verapdf`.
2. Execute the following command: <kbd>java -Dapp.home="/home/cfw/.verapdf" -jar gui-{{ site.verapdf_version_number }}-SNAPSHOT.jar --version</kbd>
3. <kbd>ls ~/.verapdf/config</kbd>

and you should see

```bash
-rw-rw-r-- 1 cfw cfw 375 Jan 28 20:36 app.xml
-rw-rw-r-- 1 cfw cfw 186 Jan 28 20:36 features.xml
-rw-rw-r-- 1 cfw cfw 109 Jan 28 20:36 fixer.xml
-rw-rw-r-- 1 cfw cfw   0 Jan 28 20:36 plugins.xml
-rw-rw-r-- 1 cfw cfw 131 Jan 28 20:36 validator.xml
```

Now proceed to use the config files in this directory, which will work as long as you use `java -Dapp.home="/home/cfw/.verapdf" -jar gui-{{ site.verapdf_version_number }}-SNAPSHOT.jar` as oppose to `java -jar gui-{{ site.verapdf_version_number }}.jar` when you start the app. This form of invocation supports all command line options, e.g.

- <kbd>java -Dapp.home="/home/cfw/.verapdf" -jar gui-{{ site.verapdf_version_number }}-SNAPSHOT.jar -f 1b somefile.pdf</kbd>
- <kbd>java -Dapp.home="/home/cfw/.verapdf" -jar gui-{{ site.verapdf_version_number }}-SNAPSHOT.jar --extract somefile.pdf</kbd>
- <kbd>java -Dapp.home="/home/cfw/.verapdf" -jar gui-{{ site.verapdf_version_number }}-SNAPSHOT.jar --policyfile my-policy.sch somefile.pdf</kbd>

### veraPDF config files
There are four config files available:

- `app.xml` configures the veraPDF CLI and GUI applications;
- `validator.xml` sets defaults for PDF/A validation;
- `fixer.xml` provides configuration of the metadata fixer; and
- `features.xml` configures feature extraction.

The sections below give a brief overview of these files and their options.

<a name="app.xml"></a>Configuring the veraPDF application
---------------------------------------------------------
A default application config file looks like:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<appConfig type="VALIDATE" maxFails="100" isOverwrite="false" format="MRR" isVerbose="false">
    <fixerFolder></fixerFolder>
    <wikiPath>https://github.com/veraPDF/veraPDF-validation-profiles/wiki/</wikiPath>
    <reportFile></reportFile>
    <reportFolder></reportFolder>
    <policyFile></policyFile>
</appConfig>
```

### <a name="appConfig"></a> appConfig
The `appConfig` element has a set of attributes can be used as follows:

- `type` controls the default processing model for the GUI, legal values are:
  - `VALIDATE` : PDF/A validation.
  - `VALIDATE_FIX` : PDF/A validation and metadata fixing.
  - `EXTRACT` : Feature extraction.
  - `VALIDATE_EXTRACT`: PDF/A validation and feature extraction.
  - `EXTRACT_FIX` : PDF/A valdiation, feature extraction and metadata fixing.
  - `POLICY` : Policy checking, this also enables PDF/A validation and feature extraction as the policy checker depends upon them.
  - `POLICY_FIX` : Policy checking and metadata fixing, again PDF/A validation and feature extraction are also enabled.
- `maxFails` specifies how many failed tests are reported per validation rule.
- `isOverwrite` tells the application whether to overwrite existing result files.
- `format` chooses the default reporting format, valid values are:
  - `MRR` : machine readable report, an XML file that has been formatted for  machine parsing and reporting.
  - `XML` : the raw XML data used by the veraPDF APIs, it's not quite as readable as the MRR format but can be de-serialised by the veraPDF API for further processing.
  - `HTML` : a formatted HTML report intended for human consumption.
  - 'TEXT' : very brief single line text output.
- `isVerbose` can be set to `false` for brief output which is the default, or `true` for verbose output.

#### <a name="fixerFolder"></a> fixerFolder
The `fixerFolder` element sets a default folder where the repaired files generated by the metadata fixer are written.

#### <a name="wikiPath"></a> wikiPath
The `wikiPath` element defines the base URL used to create reference links in the HTML report. You're unlikely to want to change this unless you intend to host your own local version
of the veraPDF validation rule wiki.

#### <a name="reportFile"></a> reportFile
The `reportFile` element defines the default name for report files generated by the application.

#### <a name="reportFolder"></a> reportFolder
The `reportFolder` element sets the folder where report files generated by the application are written.

#### <a name="policyFile"></a> policyFile
The `policyFile` element defines default policy file to be applied by the veraPDF policy checker.

<a name="validator.xml"></a>Configuring PDF/A validation
--------------------------------------------------------
The default validation config file contains:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<validatorConfig flavour="NO_FLAVOUR" recordPasses="false" maxFails="-1"/>
```

### <a name="validatorConfig"></a> The validatorConfig element
The `validatorConfig` element defines the following attributes:

- `flavour` the default flavour to use when none is specified by the user, can be PDF_A_1A, PDF_A_1B, PDF_A_2A, PDF_A_2B, PDF_A_2U, PDF_A_3A, PDF_A_3B, PDF_A_3U, PDF_UA1, or NO_FLAVOUR (for automatic detection).
- `recordPasses` set `true` to report passed validation checks, `false` to report failures only.
- `maxFails` specifies the maximum number of failed checks before validation is terminated, the default value of -1 means report all failures.

<a name="features.xml"></a>Configuring feature extraction
----------------------------------------------------
The `config/features.xml` file configures the types of PDF features extracted by the
veraPDF software. The default file contains a single entry:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<featuresConfig>
    <enabledFeatures>
        <feature>INFORMATION_DICTIONARY</feature>
    </enabledFeatures>
</featuresConfig>
```

This enables the extraction of the PDF document metadata held in the information
dictionary. You can enable the extraction of other features by adding new
`<feature>` sub-elements to the `<enabledFeatures>` element.

For reference here's a version of `features.xml` with every type of feature
enabled:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<featuresConfig>
    <enabledFeatures>
        <feature>ACTION</feature>
        <feature>ANNOTATION</feature>
        <feature>COLORSPACE</feature>
        <feature>DOCUMENT_SECURITY</feature>
        <feature>EMBEDDED_FILE</feature>
        <feature>EXT_G_STATE</feature>
        <feature>FONT</feature>
        <feature>FORM_XOBJECT</feature>
        <feature>ICCPROFILE</feature>
        <feature>IMAGE_XOBJECT</feature>
        <feature>INFORMATION_DICTIONARY</feature>
        <feature>INTERACTIVE_FORM_FIELDS</feature>
        <feature>LOW_LEVEL_INFO</feature>
        <feature>METADATA</feature>
        <feature>OUTLINES</feature>
        <feature>OUTPUTINTENT</feature>
        <feature>PAGE</feature>
        <feature>PATTERN</feature>
        <feature>POSTSCRIPT_XOBJECT</feature>
        <feature>PROPERTIES</feature>
        <feature>SHADING</feature>
        <feature>SIGNATURE</feature>
    </enabledFeatures>
</featuresConfig>
```

### <a name="action"></a> ACTION
Lists all acton elements assiocated with various document, page, interactive form events. The extracted action
element contains information about the action type and location (document, page, annotation, outline) to which this action was associated.

### <a name="annotation"></a> ANNOTATION
Lists all of the annotations found within the document. The extracted annotation
elements contain detailed information about annotation e.g. type, location, references to the annotation resources and other annotations used used by an annotation.

### <a name="colorspace"></a> COLORSPACE
Lists all colour spaces contained in the document. The description of each
color space contains details relevant for given color space family. The family is specified in family attribute. Possible color space families are:

- DeviceGray
- DeviceRGB
- DeviceCMYK
- CalGray
- CalRGB
- Lab
- ICCBased
- Indexed
- Pattern
- Separation
- DeviceN

### <a name="security"></a> DOCUMENT_SECURITY
Requests information about document security including encryption, password
protection and permissions.

### <a name="embedded-file"></a> EMBEDDED_FILE
Extracts information about any embedded files contained within a PDF document.

### <a name="graphics-state"></a> EXT_G_STATE
Lists the graphic states used in the document and their properties, e.g. transparency.

### <a name="font"></a> FONT
Lists any fonts used in the document. The description of each font contains the details relevant for given font type. The children elements of the font element:

- subtype
- name
- baseName
- firstChar
- lastChar
- widths
- encoding
- embedded
- subset
- fontDescriptor (the font descriptor describing the font's metrics other then its glyph widths)

### <a name="forms"></a> FORM_XOBJECT
Extracts information about any forms contained in the document.

### <a name="icc-profile"></a> ICCPROFILE
Configures the extraction of ICC profiles contained in the PDF document.

### <a name="image"></a> IMAGE_XOBJECT
Extracts information about the images contained in the document like height, width and compression used.

### <a name="info-dict"></a> INFORMATION_DICTIONARY
This enables the extraction of key-value pairs from the PDF Document information dictionary. The dictionary key name is saved as the value of the key argument; the dictionary value is saved as the value of the entry element

### <a name="form-fields"></a> INTERACTIVE_FORM_FIELDS
Extracts information about all interactive form fields found in the document. The extracted information includes the name of the form field and its value. 

### <a name="low-level"></a> LOW_LEVEL_INFO
Extract information about indirect objects, the document ID as well as
compression / decoding filters used in the document.

### <a name="metadata"></a> METADATA
Requests reporting of the document-level XMP metadata package exactly as it is in the original PDF Document or, if automatic XMP metadata fixing is enabled, in the resulting PDF Document. Since XMP serialization is based on XML there is no need to change in the serialized XMP packet, except for encoding. If the encoding used by XMP differs from encoding used for Report generation, the XMP will be re-encoded to make it consistent with the rest of the Report.

### <a name="outlines"></a> OUTLINES
Extracts information pertaining to any bookmarks in the document.

### <a name="output-intent"></a> OUTPUTINTENT
Requests the extraction of information about the document's output intents.

### <a name="page"></a> PAGE
Lists the page elements, each representing a page in the PDF document. This includes information about:

- media boxes;
- crop boxes;
- trim boxes;
- bleed boxes;
- art boxes;
- rotation;
- scaling;
- thumbnails;
- resources, including reference to fonts and images used on a page; and
- annotations.

### <a name="pattern"></a> PATTERN
Gathers information about the patterns contained in the PDF.

### <a name="postscript"></a> POSTSCRIPT_XOBJECT
Extracts information about any PostScript fragments used when printing to a PostScript device.

### <a name="properties"></a> PROPERTIES
Lists the properties dictionaries.

### <a name="shading"></a> SHADING
Lists the shadings used in the document.

### <a name="signature"></a> SIGNATURE
Extracts information about any digital signatures contained in the document.

<a name="plugins.xml"></a> Configuring plugins
----------------------------------------------------
The `config/plugins.xml` file configures plug in components for veraPDF. The default file contains an empty entry:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<pluginsConfig/>
```

To add a plug in execution the `plugin` element shall be specified.

For reference here's an example of `plugins.xml` with single plugin enabled:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<pluginsConfig>
    <plugin enabled="true">
        <name>Plugin Name</name>
        <version>1.0.1</version>
        <description>Some plugin description</description>
        <pluginJar>pluginPath/plugin.jar</pluginJar>
        <attributes>
            <attribute key="attrKey" value="attrValue"/>
            <attribute key="attr2Key" value="attr2Value"/>
        </attributes>
    </plugin>
</pluginsConfig>
```

### <a name="enabled"></a> enabled
The `enabled` attribute specified if the plugin shall be executed during features extracting or not. This attribute
can be used for temporary disabling the plugin without removing the configuration data for the plugin.

### <a name="name"></a> name
This is a plug in name which will be added into features report.

### <a name="version"></a> version
This is a plug in version which will be added into features report.

### <a name="description"></a> description
This is a plug in description which will be added into features report.

### <a name="pluginJar"></a> plugin jar
This is a path to plug in jar file. Shall be either absolute or relative to veraPDF installation folder.

### <a name="attributes"></a> attributes
This is a list of `attribute` nodes. Each of them contains two xml attributes `key` and `value`.
The resulted map will be used as attributes map for the plug in.

<a name="fixer.xml"></a>Configuring the metadata fixer
----------------------------------------------------
```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<fixerConfig fixId="true" fixesPrefix="veraFixMd_"/>
```
