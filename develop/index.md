---
layout: page
title: Developing with veraPDF
---

This is a quick start guide for developers wanting to work with veraPDF. You'll
need to know a little Java, Maven and git to follow the instructions. We've
assumed you either want to:

- integrate veraPDF into your own Java application; or
- contribute to the veraPDF code base.

Whatever your destination, we'll start the journey together. First you'll need to
decide which version of veraPDF you want to use and how you want to obtain it.

License
-------
VeraPDF free software: you can redistribute it and/or modify it under the terms
of either:

- The [GNU General public license GPLv3+](LICENSE.GPL), see
  - [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/) or
  - [https://www.gnu.org/licenses/gpl-3.0.en.html](https://www.gnu.org/licenses/gpl-3.0.en.html).
- The [Mozilla Public License MPLv2+](LICENSE.MPL), see
  [https://mozilla.org/MPL/2.0/](https://mozilla.org/MPL/2.0/)

Getting veraPDF
---------------
There are two implementations of the veraPDF software library, one that uses a
fork of the [Apache PDFBox project](https://github.com/veraPDF/veraPDF-pdfbox)
as a PDF parser and validation model. 

#### Greenfield vs PDFBox

Since releasing the PDFBox implementation
the veraPDF consortium have developed their own "Greenfield" PDF parsing and validation model 
that's available under the same dual open source licenses as the rest of veraPDF.
You can also use PDFBox under the APL license. We recommend using Greenfield parser, as the support for PDFBox parser is not guaranteed to be available long term.

#### Greenfield POM dependency
To include veraPDF's greenfield parser and validation model add:

```xml
<dependency>
  <groupId>org.verapdf</groupId>
  <artifactId>validation-model</artifactId>
  <version>1.26.1</version>
</dependency>
```

You can change the version number if you desire.

#### PDFBox POM dependency
This can be included in your project with this Maven dependency:

```xml
<dependency>
  <groupId>org.verapdf</groupId>
  <artifactId>pdfbox-validation-model</artifactId>
  <version>1.26.1</version>
</dependency>
```

### javax vs jakarta
Both implementations above depend on javax. If your project uses jakarta, you should use alternative dependencies:

```xml
<dependency>
  <groupId>org.verapdf</groupId>
  <artifactId>validation-model-jakarta</artifactId>
  <version>1.26.1</version>
</dependency>
```

for Greenfield implementation and 

```xml
<dependency>
  <groupId>org.verapdf</groupId>
  <artifactId>pdfbox-validation-model-jakarta</artifactId>
  <version>1.26.1</version>
</dependency>
```

for PDFBox implementation.

### GitHub for source code
The up to date source repos are on GitHub.

#### Greenfield GitHub project
The clone and build the veraPDF consortium's greenfield implementation using git
and Maven:

```shell
git clone https://github.com/veraPDF/veraPDF-validation.git
cd veraPDF-validation
mvn clean install
```

#### PDFBox version GitHub project
For the PDFBox implementation:

```shell
git clone https://github.com/veraPDF/veraPDF-pdfbox-validation.git
cd veraPDF-pdfbox-validation
mvn clean install
```

Validating a PDF
----------------
To use the library to validate a PDF file you can do the following:

### Initialising your chosen foundry
The veraPDF library is unaware of the implementations and needs to be
initialised before first use. This is a slightly different process, depending on
whether you've chosen the greenfield or PDFBox implementation.

#### Greenfield Foundry initialise

```java
import org.verapdf.core.EncryptedPdfException;
import org.verapdf.core.ModelParsingException;
import org.verapdf.core.ValidationException;
import org.verapdf.gf.foundry.VeraGreenfieldFoundryProvider;
import org.verapdf.pdfa.Foundries;
import org.verapdf.pdfa.PDFAParser;
import org.verapdf.pdfa.results.ValidationResult;
import org.verapdf.pdfa.PDFAValidator;
import org.verapdf.pdfa.flavours.PDFAFlavour;

VeraGreenfieldFoundryProvider.initialise();
```

#### PDFBox Foundry initialise

```java
import org.verapdf.core.EncryptedPdfException;
import org.verapdf.core.ModelParsingException;
import org.verapdf.core.ValidationException;
import org.verapdf.pdfbox.foundry.PdfBoxFoundryProvider;
import org.verapdf.pdfa.Foundries;
import org.verapdf.pdfa.PDFAParser;
import org.verapdf.pdfa.results.ValidationResult;
import org.verapdf.pdfa.PDFAValidator;
import org.verapdf.pdfa.flavours.PDFAFlavour;

PdfBoxFoundryProvider.initialise();
```

### Validating a PDF File
You only need to initialise once, whichever version you're using, now the code to
validate a file called `mydoc.pdf` against the PDF/A 1b specification is:

```java
PDFAFlavour flavour = PDFAFlavour.fromString("1b");
try (PDFAParser parser = Foundries.defaultInstance().createParser(new FileInputStream("mydoc.pdf"), flavour)) {
    PDFAValidator validator = Foundries.defaultInstance().createValidator(flavour, false);
    ValidationResult result = validator.validate(parser);
    if (result.isCompliant()) {
      // File is a valid PDF/A 1b
    } else {
      // it isn't
    }
} catch (IOException | ValidationException | ModelParsingException | EncryptedPdfException exception) {
	// Exception during validation
}
```

If you're not sure what specification to use you can let the software decide:

```java
try (PDFAParser parser = Foundries.defaultInstance().createParser(new FileInputStream("mydoc.pdf"))) {
    PDFAValidator validator = Foundries.defaultInstance().createValidator(parser.getFlavour(), false);
    ValidationResult result = validator.validate(parser);
    if (result.isCompliant()) {
      // File is a valid PDF/A 1b
    } else {
      // it isn't
    }
} catch (IOException | ValidationException | ModelParsingException | EncryptedPdfException exception) {
	// Exception during validation
}
```

The veraPDF Processor
---------------------
There's a higher level processor API aimed at developers wanting to combine the
low-level components. You can read more in on the [processor page](processor).
