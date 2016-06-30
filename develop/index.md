---
layout: page
title: Developing with veraPDF
---

Integrating veraPDF
-------------------

## Overview

The main entry point to integrate veraPDF project into another one is to use the class that implements org.verapdf.processor.Processor interface. Now we have one implementation of that interface based on pdf-box: org.verapdf.processor.ProcessorImpl.

The interface contains one method:

    validate(InputStream, ItemDetails, Config, OutputStream) : ProcessingResult

This method can be used as an entry point for veraPDF processing. It takes the following arguments:

 - `InputStream` is a PDF file input stream for processing;
 - `ItemDetails` contains the filename and file size. In case if the local PDF file it can be derived from the corresponding File object. However, in other cases such as for example HTTP input stream this data should be provided in addition to the stream itself.
 - `Config` contains all configuration parameters for processing.
 - `OutputStream` is used to write the report.
 - As a result of processing, the method returns `ProcessingResult` object that contains general information about status of the process (or processes, if for example feature report generation or metadata fixing is requested in addition to validation) and other debug level info (such as the list of all exceptions caught during processing).

## Example Integration
{% highlight java %}
public static void main(String[] args) {
   try {
     /* Create default config and change its properties if necessary
        As an example here will be used some setters for changing most
        important config values, but does not use all of them.
        See the Config class documentation for additional info */

        Config config = new Config();

        // Validation will end when reaching this number of failed checks.
        // Default value: -1 (ignore this property)
       // config.setMaxNumberOfFailedChecks(-1);

       // Include PDF features into the report
	     // The use of this option might significantly increase the size
       // of the report and memory consumption.
       // Default value: VALIDATION
       // config.setProcessingType(ProcessingType.VALIDATION_AND_FEATURES);

       // Enable metadata fixing.
       // A modified PDF file will be saved next to the source PDF
       // Default value: false
       // config.setFixMetadata(true);

       // If the next property will be set, then metadata fixer will use specified
        // folder for saving fixed file. Use empty path (see default) to disable
        // that property
        // Default value: FileSystems.getDefault().getPath(“”);
        // config.setFixMetadataPathFolder(FileSystems.getDefault().getPath(“folder”));

        // The fixed file name created by using the next logic:
        // prefix + filename + index + extension, where
        // prefix - String that specified by the next property
        // filename - part of initial file’s name before first ‘.’ symbol,
        // index - if there is no file with name prefix + filename + extension in
        // the folder, then index will be empty string, otherwise it will be equal to
        // “(“ + number + “)”, where number is the least integer such that
        // there will be no name conflicts
        // extension - initial file’s extension
        // Default value: “veraPDF_”
        // config.setMetadataFixerPrefix(“somePrefix_”);

        // Choose report type (MRR, XML, TXT, HTML)
       // Default value: MRR (machine-readable report)
       // config.setReportType(FormatOption.MRR);

      // Choose validation flavour
       // Default value: AUTO
       // config.setFlavour(PDFAFlavour.PDFA_1_B);

       // Prepare file for processing and set the output stream for the report
       File pdf = new File("location/file.pdf");
       InputStream fileInputStream = new FileInputStream(pdf);
       OutputStream os = System.out;

      // Starting the processing
      Processor processor = new ProcessorImpl();
      ProcessingResult result =
      processor.validate(fileInputStream, ItemDetails.fromFile(pdf), config, os);
   } catch (FileNotFoundException | ModelParsingException e) {
       e.printStackTrace();
   }
}
{% endhighlight %}
