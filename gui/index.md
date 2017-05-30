---
layout: page
title: Desktop GUI Guide
redirect_from:
  - /getting-started/gui/
description: Find out how to download and install the veraPDF software.
group: getting-started
---

This Quick Start Guide explains some basic concepts relavent to the veraPDF Conformance Checker and helps you to get started with veraPDF Desktop GUI.

![veraPDF logo](/images/vera-logo-shadow.jpg "veraPDF logo")

Contents
--------
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}

## Introduction
The veraPDF Consortium provides open source PDF/A validation developed with the support of the PDF industry. The veraPDF Conformance Checker uses the veraPDF Java library, which provides the APIs and implementations for PDF/A Validation, Policy Checking, Metadata Repair, and Reporting. The veraPDF Desktop Graphical User Interface (GUI) allows users to run the software on a desktop computer or workstation.

### Overview
The veraPDF GUI provides the features of veraPDF PDF/A Java Library in a desktop windows GUI. Users can configure their own PDF/A validation and policy checking jobs by selecting:
- which combination of tasks to perform;
- PDF Documents to analyse;
- the PDF/A part and conformance level to test for; and
- various task specific settings.

The software carries out the configured task and reports the results in both XML and HTML formats. The XML report is intended for consumption by automated processes while the HTML report is designed for human readablilty.

## Using the GUI
You can start the GUI application by executing a script within the application installation folder. Depending on your Operating System you'll need:

- for Mac OSX, Linux and Unix users: `verapdf-gui`
- on Windows users: `verapdf-gui.bat`

If the application is installed properly you'll see this window:

![veraPDF GUI main screen](/images/gui/main-screen.png "veraPDF GUI main screen"){: .img-responsive .center-block}

The interface is fairly simple, we describe the controls in the following sections.

### Choose PDF button
This opens the file dialog, allowing the user to select a PDF file for validation or feature reporting. The "Execute" button will not be enabled until a file is selected.

### The PDF/A flavour dropdown and Choose Profile button
The PDF/A flavour dropdown is used to control validation processing. The user can:
- select any of the built in PDF/A Validation Profiles;
- allowing the software to select a Validation Profile by analysing the PDF/A document metadata; or
- choose to load a custom Validation Profile from their filesystem.
For most users allowing the software to decide or enforcing one of the profiles packaged with the software will be sufficient. The dropdown looks like this:

![veraPDF GUI profile dropdown](/images/gui/profile-list.png "veraPDF GUI profile dropdown"){: .img-responsive .center-block}

A full description of the available options is given in the following table:

| Option         | Description                                                                                               |
|----------------|-----------------------------------------------------------------------------------------------------------|
| Auto-detection | The veraPDF software will detect the PDF/A flavour when parsing the file and use the appropriate profile. |
| PDF/A-1a       | Use the PDF/A-1a validation profile, i.e. assume that the file is a PDF/A-1a.                             |
| PDF/A-1b       | Use the PDF/A-1b validation profile, i.e. assume that the file is a PDF/A-1b.                             |
| PDF/A-2a       | Use the PDF/A-2a validation profile, i.e. assume that the file is a PDF/A-2a.                             |
| PDF/A-2b       | Use the PDF/A-2b validation profile, i.e. assume that the file is a PDF/A-2b.                             |
| PDF/A-2u       | Use the PDF/A-2u validation profile, i.e. assume that the file is a PDF/A-2u.                             |
| PDF/A-3a       | Use the PDF/A-3a validation profile, i.e. assume that the file is a PDF/A-3a.                             |
| PDF/A-3b       | Use the PDF/A-3b validation profile, i.e. assume that the file is a PDF/A-3b.                             |
| PDF/A-3u       | Use the PDF/A-3u validation profile, i.e. assume that the file is a PDF/A-3u.                             |
| Custom Profile | Enables the Choose Profile button allowing the user to load an external validation profile.               |
{:.table .table-striped .table-bordered}

### <a name="report-drop"></a>Report Type dropdown, Choose Policy button, and Fix Metadata checkbox
These controls allow the user to select the processing functionality and the information included in the generated report:

![veraPDF GUI report dropdown](/images/gui/report-list.png "veraPDF GUI report dropdown"){: .img-responsive .center-block}

The available options are:

| Option                | Description                                                                            |
|-----------------------|----------------------------------------------------------------------------------------|
| Validation [default]  | Performs PDF/A Validation only and report the results.   |
| Features              | Only carries out Feature Reporting, doesn't attempt to validate the PDF file.                  |
| Validation & Features | Perform both PDF/A Validation and Features Reporting  and report the results. |
| Policy                | Carries out all three processes, Policy Checking, PDF/A Validation and Feature Extraction.                    |
{:.table .table-striped .table-bordered}

If Policy is selected the "Choose Policy" button is activated, pressing this opens a file dialog that allow the user to load a [policy schematron file](/policy).

If the Fix Metadata checkbox is selected veraPDF will attempt simple repairs of the PDF document metadata to ensure compliance with the PDF/A specification.

### Execute button
This button is only enabled when a PDF file has been chosen. If you've chosen to use a custom validation profile from the dropdown then you must also select an external profile file. Once enabled and pressed the PDF file will be processed according to the selected options.

### View Report buttons
Once processing is complete the reporting buttons will be enabled:

| Option    | Description                                                    |
|-----------|----------------------------------------------------------------|
| Save XML  | Saves the processing results as a machine parsable XML report. |
| Save HTML | Saves the processing results as a human friendly HTML report.  |
| View XML  | Opens the machine parsable report in the default XML viewer.   |
| View HTML | Opens the human friendly report in the default HTML viewer.    |
{:.table .table-striped .table-bordered}

The XML report will contain PDF/A Validation Report and PDF Features Report, depending on the chosen processing options. Currently the HTML report only includes the results PDF/A Validation information.

![veraPDF GUI populated screen](/images/gui/populated.png "veraPDF GUI main screen"){: .img-responsive .center-block}

Once a PDF File is selected, and possibly a custom profile depending upon the dropdown, the ‘Validate’ button becomes enabled.

The main window allows specifying the basic settings of the validation process: the type of the data included into the resulting Machine-readable Report and if automatic metadata fixing is enabled.

## Advanced Settings
The additional ‘Settings’ dialog allows the user to configure the advanced settings:

![veraPDF GUI settings](/images/gui/settings.png "veraPDF GUI settings dialog"){: .img-responsive .center-block}

The advanced settings are described in the table below:

| Setting              | Description |
|----------------------|-------------|
| Include passed rules | If checked the passed validation rules are included into the resulting PDF/A Validation Report in addition to the failed rules. This setting is unchecked by default to reduce the size of the resulting Report |
| Stop validating after failed checks | Specifies the maximum number of failed checks to be performed for all rules in the Validation Profile. Validation is halted once the number of failed checks is reached in order to speed up validation.  |
| Display failed checks for rule | Specifies the maximum number of failed checks to be reported for each rule from the Validation Profile. The specified value is used as the limit for the number of failed checks that shall be included into the resulting Report to reduce the size of the Report. |
| Save fixed files with prefix | Specifies the prefix that is added to the name of the original PDF document when saving it after automatic metadata fixing was performed. This setting is used only when ‘Fix metadata’ option is enabled |
| Save fixed files into the folder | Specifies the output folder for saving the PDF Documents after automatic metadata fixing was performed. Again this setting is relevant only when ‘Fix metadata’ option is enabled |
| Validation profile wiki root | Specifies the base URL of the veraPDF validation profiles wiki. This provides contextual information about validation issues. |
{:.table .table-striped .table-bordered}

## Processing and Reporting
A Validation Profile describes the tests that shall be performed during the validation. These tests are represented by rules that define a certain restrictions on the PDF Document features. When validation is performed the restrictions from the rules are checked for the relevant objects from PDF Document. A check may either fail or pass. In case of large Documents the number of passed and failed checks may be big so the settings described above allow reducing the number of redundant checks and thus optimizing validation time and the size of resulting Report.

When all the required settings are specified the validation may be started by pressing the ‘Execute’ button. During the processing the progress bar is displayed. After the validation is finished the resulting statement is shown as in the example image below:

![veraPDF GUI results](/images/gui/results.png "veraPDF GUI results display"){: .img-responsive .center-block}

It is possible to save or view the resulting XML or HTML reports by pressing the corresponding button.
