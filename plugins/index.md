---
layout: page
title: veraPDF Plugins
---

## Overview
If a user wants to use a third-party Tool for extracting additional features he needs to have the Adaptor for it that shall be a part of the Plugin for veraPDF software. After the Plugin is loaded by veraPDF software the Tool becomes available for the Features Reporter through the Extractor interface.

A Plugin is represented by a `.jar` file with the Extractor class definition. This Extractor class is an extension of the [FeaturesExtractor](https://github.com/veraPDF/veraPDF-library/blob/integration/core/src/main/java/org/verapdf/features/AbstractFeaturesExtractor.java) - the base class defining the interfaces for the Features Reporter.

The veraPDF software loads the Plugins on startup. It uses plugins.xml file for enabling and configuring the plugins. That config file should be placed near the app config file `.../verapdf/config/plugins.xml`. The plugins config xml file should contain a root element `pluginsConfig`. That root element contains child elements `plugin`. Each of plugin element refers to one plugin. It can contain five children and one attribute. The attribute’s name is enabled and its value should be a `boolean true|false` value. If this value is true, then the specified plugin will be used in features collection. The child elements of the plugin element are listed in the following table:


| Element      | Description            |
|--------------|------------------------|
| name         | The name of the plugin |
| version      | The version of the plugin |
| description  | The description of the plugin |
| pluginJar    | A URL that specifies the plugin’s .jar file |
| attributes   | This element contain a number of child elements attribute. Each of child element should contain two attributes: key and value. The values of that attributes will be used for passing to the plugins attributes map which plugin can use for additional purposes (specifying the path to some external binary, additional configurations for the plugins output and etc.) |
{:.table .table-bordered .table-striped}

### Example plugin configuration file
```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<pluginsConfig>
  <plugin enabled="true">
    <name>Font Sample</name>
    <version>1.0</version>
    <description>The font sample plugin</description>
    <pluginJar>file:///home/userName/verapdf/plugins/fontSample.jar</pluginJar>
  </plugin>
  <plugin enabled="false">
    <name>iccdump</name>
    <version>1.0</version>
    <description>Collecting icc profile’s features with Argyll iccdump</description>
    <pluginJar>file:///home/userName/verapdf/plugins/iccdump.jar</pluginJar>
    <attributes>
      <attribute key="cliPath" value="/home/userName/verapdf/plugins/iccdump"/>
    </attributes>
  </plugin>
</pluginsConfig>
```

Each Plugin `.jar` file must contain a single Extractor implementation. If `.jar` file contains more than one Extractor implementation the Plugin will not be loaded and the error will be logged. The created Extractor is registered in the Features Reporter.

When the Features Reporter collects features of a PDF object it also checks if there are any registered Extractors available for the object type. In this case the Reporter creates the dataset describing the object and passes it to each registered Extractor as argument for the method to get the custom features. Extractor transforms the dataset into the form that can be understood by the Tool and requests the Tool to process it. The Tool reports the processing results which are converted by the Extractor to the custom features description. The returned custom features are added to the Features Report.

## Plugin implementation
This section describes:
  * The expected format of the features reported by a Plugin
  * The details of the Extractor implementation provided by a Plugin
  * The classes and interfaces available for a Plugin developer

### Custom features report structure
The additional features reported by third-party Tools are listed in the PDF Features Report together with the default set of features reported by veraPDF software. The `customFeatures` element is automatically added to the features list of a PDF object whenever there is an Extractor registered in the Features Reporter for the corresponding object type.

The veraPDF software expects that Extractor returns the list of elements describing the custom features. They will be added as child elements to the `pluginFeatures` element. This element is automatically added to the element `customFeatures` as soon as the Extractor returns the custom features list.

For example, a Plugin defines the Extractor that for some specific ICC profile (object with type ICCPROFILE) returns two elements describing the custom features. The element names are `theCustomFeature1` and `theCustomFeature2`. The element values are `theFeatureValue1` and `theFeatureValue2` accordingly. In this case in the Features Report the element `iccProfile` for the ICC profile object will have the additional element `customFeatures` with the following content:

#### Example
```xml
<iccProfile id="someID">
  ...
  <customFeatures>
    <pluginFeatures description="This plugin reports the features of the ICC profiles" name="plugin name" version=”1.0”>
      <theCustomFeature1>theFeatureValue1</theCustomFeature1>
      <theCustomFeature2>theFeatureValue2</theCustomFeature2>
    </pluginFeatures>
  </customFeatures>
</iccProfile>
```

The `customFeatures` element may contain many `pluginFeatures` elements if there are multiple Extractors registered for this object type. The name and version attributes identify the Plugin that was used to generate the features list. The attributes contains the value obtained from the plugins config file.

### Extractor implementation
Extractor is created from the class definition provided by the Plugin. Extractor is the extension of the base FeaturesExtractor class.

The base FeaturesExtractor class is private. However there are several Extractor class prototypes (abstract Extractor classes) which extend the base class. They are public so the user shall extend them to integrate with the Features Reporter.

There may be existing Extractors classes available that already adapt some third-party Tools. If none of existing Extractor classes can be used for some specific Tool the user needs to create and compile an additional extension of some abstract or existing Extractor class.

Extractor classes must have the empty constructor. If Extractor class uses other libraries and frameworks the user needs to make sure they are available for veraPDF software at the moment the Plugin is loaded.

The extractor can get all the necessary configuration attributes using the method that is implemented in FeaturesExtractor class:

| Method | Description |
|--------|-------------|
| getAttributes() | Returns the map which contains all the attributes that were set in the plugins config file for specified plugin |
{:.table .table-bordered .table-striped}

Each abstract Extractor defines the main method that is used by Features Reporter to get the custom features. This method must be implemented in any Extractor class definition provided by a Plugin. The name of the method depends on the PDF object type this Extractor supports. The FeaturesData object is passed to this method as argument. This object is the dataset that provides the information about the PDF object being processed.

As the result the method shall return a list of FeaturesTreeNode objects. Each of these objects is a root of a tree describing the custom features.

The method normally implements the following steps:

  1. Transform FeaturesData object into the input data for some CLI, dynamic library, web service or other type of Tool (for example, save data to temporary files in a specific format)
  2. Trigger the Tool to process it (for example, start CLI with corresponding arguments that include paths to temporary files with the input data)
  3. Transform the output of the Tool into the list of FeaturesTreeNode objects (for example, parse the CLI output XML file and add the required information as a child nodes of some root FeaturesTreeNode object)
  4. Return the generated list of FeaturesTreeNode objects to the Features Reporter

## Hello-Embedded plugin
This is an example setup for a plugin running on embedded files
### Maven
In your pom.xml you will need the possibility to refer to VeraPDF classes, i.e., a VeraPDF dependency, 
and the possibility to create a Jar file with your code but without the VeraPDF classes you just referred, e.g. using the
Maven shade plugin.

```xml
	<dependencies>
		<dependency>
			<groupId>org.verapdf</groupId>
			<artifactId>core</artifactId>
			<version>1.6.2</version>
		</dependency>
	</dependencies>
	<build>

		<plugins>
			<plugin>
				<configuration>
					<minimizeJar>true</minimizeJar>
					<filters>
						<filter>
							<artifact>*:*</artifact>
							<excludes>
								<exclude>META-INF/*.SF</exclude>
								<exclude>META-INF/*.DSA</exclude>
								<exclude>META-INF/*.RSA</exclude>
								<exclude>org/verapdf/**</exclude>
							</excludes>
							<includes>
								<include>**/**</include>
							</includes>
						</filter>
					</filters>
				</configuration>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-shade-plugin</artifactId>
				<version>3.0.0</version>
				<executions>
					<execution>
						<phase>package</phase>
						<goals>
							<goal>shade</goal>
						</goals>
					</execution>
				</executions>
			</plugin>
		</plugins>
	</build>

```
### Java

The VeraPDF plugin loader will scan for all suitable subclasses, so the class and file name, in this case EmbeddedFilePlugin, is not relevant.

```java

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
// and from VeraPDF:
import org.verapdf.core.FeatureParsingException;
import org.verapdf.features.AbstractEmbeddedFileFeaturesExtractor;
import org.verapdf.features.EmbeddedFileFeaturesData;
import org.verapdf.features.tools.FeatureTreeNode;


public class EmbeddedFilePlugin extends AbstractEmbeddedFileFeaturesExtractor {

	private static final Logger LOGGER = Logger.getLogger(EmbeddedFilePlugin.class.getCanonicalName());

	@Override
	public List<FeatureTreeNode> getEmbeddedFileFeatures(EmbeddedFileFeaturesData embeddedFileFeaturesData) {
		List<FeatureTreeNode> res = new ArrayList<>();
		try {
			FeatureTreeNode node = FeatureTreeNode.createRootNode("Hello");
			node.setValue("World");
			res.add(node);
		} catch (FeatureParsingException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
		}
		return res;
	}

}
```

### Compile, deploy and run


Compile with `mvn clean package` and Example plugin configuration file and mention and activate the target JAR as mentioned in [Example plugin configuration file](#example-plugin-configuration-file) above.


Run `verapdf-gui` and ensure that embedded files is checked in Config|Features Config.
Select a PDF file containing embedded files like [the mustangproject sample file](http://www.mustangproject.org/files/MustangGnuaccountingBeispielRE-20170509_505.pdf),
select "Validation and Features" as report type and hit the execute button.
If you then click the "View XML" button you should see a `<hello>world</hello>` in the XML output.
