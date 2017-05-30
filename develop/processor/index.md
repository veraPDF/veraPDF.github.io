---
layout: page
title: The veraPDF Processor API
---

## Overview

The main entry point to integrate veraPDF project into another one is to use the class that implements org.verapdf.processor.Processor interface.

## Example Integration
```java
public static void main(String[] args) {
	// Foundry initialising. Can be changed into PDFBox based one
	VeraGreenfieldFoundryProvider.initialise();
	// Default validator config
	ValidatorConfig validatorConfig = ValidatorFactory.defaultConfig();
	// Default features config
	FeatureExtractorConfig featureConfig = FeatureFactory.defaultConfig();
	// Default plugins config
	PluginsCollectionConfig pluginsConfig = PluginsCollectionConfig.defaultConfig();
	// Default fixer config
	MetadataFixerConfig fixerConfig = FixerFactory.defaultConfig();
	// Tasks configuring
	EnumSet tasks = EnumSet.noneOf(TaskType.class);
	tasks.add(TaskType.VALIDATE);
	tasks.add(TaskType.EXTRACT_FEATURES);
	tasks.add(TaskType.FIX_METADATA);
	// Creating processor config
	ProcessorConfig processorConfig = ProcessorFactory.fromValues(validatorConfig, featureConfig, pluginsConfig, fixerConfig, tasks);
	// Creating processor and output stream. In this example output stream is System.out
	try (BatchProcessor processor = ProcessorFactory.fileBatchProcessor(processorConfig);
		 OutputStream reportStream = System.out) {
		// Generating list of files for processing
		List<File> files = new ArrayList<>();
		files.add(new File("location/file.pdf"));
		// starting the processor
		processor.process(files, ProcessorFactory.getHandler(FormatOption.MRR, true, reportStream,
						100, processorConfig.getValidatorConfig().isRecordPasses()));
	} catch (VeraPDFException e) {
		System.err.println("Exception raised while processing batch");
		e.printStackTrace();
	} catch (IOException excep) {
		System.err.println("Exception raised closing MRR temp file.");
		excep.printStackTrace();
	}
}
```
