---
layout: page
title: GUI
---

veraPDF Desktop GUI : Quick start guide
----------------------------------------

![veraPDF logo](/images/vera-logo-shadow.jpg "veraPDF logo")

## Introduction

The veraPDF Consortium provides the implementation of the Definitive PDF/A Conformance Checker.

The veraPDF Conformance Checker is implemented using the veraPDF Library. The veraPDF Library is the software library that provides the functionality and APIs for PDF/A Validation, Policy Checking, Metadata Fixing, and Reporting.

The veraPDF Desktop Graphical User Interface (GUI) is the executable program that provides access to the veraPDF API and Library on a desktop computer or workstation.

This Quick Start Guide explains the basic concepts of veraPDF Conformance Checker and helps you to get started with veraPDF Desktop GUI.

## The veraPDF Desktop GUI overview

The veraPDF Desktop GUI provides the convenient access to the features of veraPDF PDF/A Conformance Checker. It allows configuring input parameters of PDF/A Validation (PDF Document, Validation Profile, validation settings), performing actual validation and checking the resulting Machine-readable and Human-readable Reports.

## Using veraPDF Desktop GUI

The application installation folder contains the script that shall be executed to launch veraPDF Desktop GUI application. The script name depends on the platform:

- on Mac OSX and Unix systems: verapdf-gui
- on Windows systems: verapdf-gui.bat

When the application is started the following screen is displayed:

![veraPDF GUI main screen](/images/gui/main-screen.png "veraPDF GUI main screen")

The interface is fairly simple, we describe the controls int he following section.

### GUI controls

#### Choose PDF button
This opens the file dialog, allowing the user to select a PDF file for validation or feature reporting. The "Execute" button will not be enabled until a file is selected.

#### Choose Profile button and Profile dropdown
The Choose Profile button and the dropdown immediately below it determine the validation processing. The Choose Profile button allows a user to load a custom Validation Profile from the file system. For most users the built in profiles packaged with the software will be sufficient. The dropdown below the button is used to control profile selection:

![veraPDF GUI profile dropdown](/images/gui/profile-list.png "veraPDF GUI profile dropdown")

The options are as follows:

| Option         | Description                                                                                               |
|----------------|-----------------------------------------------------------------------------------------------------------|
| PDF/A-1a       | Use the PDF/A-1a validation profile, i.e. assume that the file is a PDF/A-1a.                             |
| PDF/A-1b       | Use the PDF/A-1b validation profile, i.e. assume that the file is a PDF/A-1b.                             |
| PDF/A-2a       | Use the PDF/A-2a validation profile, i.e. assume that the file is a PDF/A-2a.                             |
| PDF/A-2b       | Use the PDF/A-2b validation profile, i.e. assume that the file is a PDF/A-2b.                             |
| PDF/A-2u       | Use the PDF/A-2u validation profile, i.e. assume that the file is a PDF/A-2u.                             |
| PDF/A-3a       | Use the PDF/A-3a validation profile, i.e. assume that the file is a PDF/A-3a.                             |
| PDF/A-3b       | Use the PDF/A-3b validation profile, i.e. assume that the file is a PDF/A-3b.                             |
| PDF/A-3u       | Use the PDF/A-3u validation profile, i.e. assume that the file is a PDF/A-3u.                             |
| Auto-detection | The veraPDF software will detect the PDF/A flavour when parsing the file and use the appropriate profile. |
| Custom Profile | Enables the Choose Profile button allowing the user to load an external validation profile.               |
{:.table .table-striped}

#### Report Type dropdown, Policy button, and Fix Metadata checkbox
These controls allow the user to select the processing functionality and the information included in the generated report:

![veraPDF GUI report dropdown](/images/gui/report-list.png "veraPDF GUI report dropdown")

The available options are:

| Option                | Description                                                                            |
|-----------------------|----------------------------------------------------------------------------------------|
| Validation [default]  | Only perform PDF/A Validation and report the results, feature reporting is disabled.   |
| Features              | Only carry out feature reporting, don't try to validate the PDF file.                  |
| Validation & Features | Both PDF/A Validation and features reporting are carried out and the results reported. |
| Policy                | Perform a Policy check alongside validation and feature extraction.                    |
{:.table .table-striped}

If Policy is chosed the "Choose Policy" is activated, the user can then press this and load a [policy schematron file](/cli/policy).

The Fix Metadata checkbox determines whether the software will attempt to ammend the PDF document metadata to ensure it is compliant whith the PDF/A specification.

#### Execute button
This button is only enabled when a PDF file has been chosen. If you've chosen to use a custom validation profile from the dropdown then you must also select an external profile file. Once enabled and pressed the PDF file will be processed according to the selected options.

#### View Report buttons
Once processing is complete the reporting buttons will be enabled:

| Option    | Description                                                    |
|-----------|----------------------------------------------------------------|
| Save XML  | Saves the processing results as a machine parsable XML report. |
| Save HTML | Saves the processing results as a human friendly HTML report.  |
| View XML  | Opens the machine parsable report in the default XML viewer.   |
| View HTML | Opens the human friendly report in the default HTML viewer.    |
{:.table .table-striped}

The XML report will contain PDF/A Validation Report and PDF Features Report, depending on the chosen processing options. Currently the HTML report only includes the results PDF/A Validation information.

![veraPDF GUI populated screen](/images/gui/populated.png "veraPDF GUI main screen")

Once a PDF File is selected, and possibly a custom profile depending upon the dropdown, the ‘Validate’ button becomes enabled.

The main window allows specifying the basic settings of the validation process: the type of the data included into the resulting Machine-readable Report and if automatic metadata fixing is enabled.

### Advanced Settings
The additional ‘Settings’ dialog allows the user to configure the advanced settings:

![veraPDF GUI settings](/images/gui/settings.png "veraPDF GUI settings dialog")

The advanced settings are described in the table below:

| Setting              | Description |
|----------------------|-------------|
| Include passed rules | If checked the passed validation rules are included into the resulting PDF/A Validation Report in addition to the failed rules. This setting is unchecked by default to reduce the size of the resulting Report |
| Stop validating after failed checks | Specifies the maximum number of failed checks to be performed for all rules in the Validation Profile. Validation is halted once the number of failed checks is reached in order to speed up validation.  |
| Display failed checks for rule | Specifies the maximum number of failed checks to be reported for each rule from the Validation Profile. The specified value is used as the limit for the number of failed checks that shall be included into the resulting Report to reduce the size of the Report. |
| Save fixed files with prefix | Specifies the prefix that is added to the name of the original PDF document when saving it after automatic metadata fixing was performed. This setting is used only when ‘Fix metadata’ option is enabled |
| Save fixed files into the folder | Specifies the output folder for saving the PDF Documents after automatic metadata fixing was performed. Again this setting is relevant only when ‘Fix metadata’ option is enabled |
| Validation profile wiki root | Specifies the base URL of the veraPDF validation profiles wiki. This provides contextual information about validation issues. |
{:.table .table-striped}

### Processing and Reporting
A Validation Profile describes the tests that shall be performed during the validation. These tests are represented by rules that define a certain restrictions on the PDF Document features. When validation is performed the restrictions from the rules are checked for the relevant objects from PDF Document. A check may either fail or pass. In case of large Documents the number of passed and failed checks may be big so the settings described above allow reducing the number of redundant checks and thus optimizing validation time and the size of resulting Report.

When all the required settings are specified the validation may be started by pressing the ‘Execute’ button. During the processing the progress bar is displayed. After the validation is finished the resulting statement is shown as in the example image below:

![veraPDF GUI results](/images/gui/results.png "veraPDF GUI results display")

It is possible to save or view the resulting XML or HTML reports by pressing the corresponding button.
