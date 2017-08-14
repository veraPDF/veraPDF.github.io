---
layout: page
title: veraPDF CLI Feature Extraction
---

As well as validating PDF/A documents the veraPDF software can also be used to
extract metadata from PDF files. This is known as Feature Extraction. Before we
look at this functionality a word about configuration to control the features
the software extracts.

Configuring the feature extractor
---------------------------------
The feature extractor can generate a lot of output most of which isn't of
interest to most users. By default veraPDF is configured to extract some
minimal PDF metadata. You can read about configuring the feature reporter
on the [configuration page](../config#features.xml). As we work through some
examples we'll show how to configure the application to extract the necessary
information.

Disabling PDF/A validation
--------------------------
veraPDF runs PDF/A validation by default, when calling the feature extractor you
may want to [disable PDF/A validation](../validation#disable).

Extracting PDF Features
-----------------------
The following examples illustrate how to extract some of the features from PDF
documents.

### <a name="info-dict"></a> Information Dictionary
Many of the files in the veraPDF test corpus don't have any information in the
information dictionary as they're designed to be minimal, sythetic test files.
To demonstrate these features we'll use an Adobe specification file `adobe_supplement_iso32000.pdf`, available for [download here](http://wwwimages.adobe.com/content/dam/Adobe/en/devnet/pdf/pdfs/adobe_supplement_iso32000.pdf). We'll assume that it's downloaded in the current
directory.

Ensure that the feature extractor is configured properly. To make the
demonstration clear we suggest you edit your [config/features.xml](../config#features.xml) to read:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<featuresConfig>
    <enabledFeatures>
        <feature>INFORMATION_DICTIONARY</feature>
    </enabledFeatures>
</featuresConfig>
```

ensuring that only the information dictionary fields are extracted. Then issue
the following command:

<kbd>verapdf --off --extract adobe_supplement_iso32000.pdf</kbd>

you should see the following output:

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
      <item size="1373256">
        <name>/home/cfw/verapdf/dev/adobe_supplement_iso32000.pdf</name>
      </item>
      <featuresReport>
        <informationDict>
          <entry key="Title">Acrobat Supplement to the ISO 32000</entry>
          <entry key="Author">Adobe Developer Support</entry>
          <entry key="Subject">Adobe Acrobat 9.0 SDK</entry>
          <entry key="Creator">FrameMaker 7.2</entry>
          <entry key="Producer">Acrobat Distiller 9.0.0 (Windows)</entry>
          <entry key="CreationDate">2008-05-22T15:17:22.000Z</entry>
          <entry key="ModDate">2008-05-29T17:07:38.000-07:00</entry>
        </informationDict>
      </featuresReport>
      <processingTime>00:00:00:053</processingTime>
    </job>
  </jobs>
  <summary jobs="1" failedJobs="0" valid="0" inValid="0" validExcep="0" features="1">
    <duration start="1485201793805" finish="1485201794254">00:00:00:449</duration>
  </summary>
</report>
```

### <a name="metadata"></a> XMP Metadata
We'll use the same [adobe supplement file](http://wwwimages.adobe.com/content/dam/Adobe/en/devnet/pdf/pdfs/adobe_supplement_iso32000.pdf) to demonstrate the extraction of XMP metadata. First
you'll need touse a text editor to change the contents of your
[config/features.xml](../config#features.xml) to read:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<featuresConfig>
    <enabledFeatures>
        <feature>METADATA</feature>
    </enabledFeatures>
</featuresConfig>
```

then type:

<kbd>verapdf --off --extract adobe_supplement_iso32000.pdf</kbd>

to get the following output:

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
      <item size="1373256">
        <name>/home/cfw/verapdf/dev/adobe_supplement_iso32000.pdf</name>
      </item>
      <featuresReport>
        <metadata>
          <xmpPackage>
            <x:xmpmeta x:xmptk="Adobe XMP Core 4.2.1-c041 52.332438, 2008/03/16-20:10:24        " xmlns:x="adobe:ns:meta/">
              <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                <rdf:Description xmlns:xmp="http://ns.adobe.com/xap/1.0/" rdf:about="">
                  <xmp:CreatorTool>FrameMaker 7.2</xmp:CreatorTool>
                  <xmp:ModifyDate>2008-05-29T17:07:38-07:00</xmp:ModifyDate>
                  <xmp:CreateDate>2008-05-22T15:17:22Z</xmp:CreateDate>
                  <xmp:MetadataDate>2008-05-29T17:07:38-07:00</xmp:MetadataDate>
                </rdf:Description>
                <rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1/">
                  <dc:format>application/pdf</dc:format>
                  <dc:title>
                    <rdf:Alt>
                      <rdf:li xml:lang="x-default">Acrobat Supplement to the ISO 32000</rdf:li>
                    </rdf:Alt>
                  </dc:title>
                  <dc:creator>
                    <rdf:Seq>
                      <rdf:li>Adobe Developer Support</rdf:li>
                    </rdf:Seq>
                  </dc:creator>
                  <dc:description>
                    <rdf:Alt>
                      <rdf:li xml:lang="x-default">Adobe Acrobat 9.0 SDK</rdf:li>
                    </rdf:Alt>
                  </dc:description>
                </rdf:Description>
                <rdf:Description xmlns:pdf="http://ns.adobe.com/pdf/1.3/" rdf:about="">
                  <pdf:Producer>Acrobat Distiller 9.0.0 (Windows)</pdf:Producer>
                </rdf:Description>
                <rdf:Description xmlns:xmpMM="http://ns.adobe.com/xap/1.0/mm/" rdf:about="">
                  <xmpMM:DocumentID>uuid:d5b217b3-93ee-471c-8fa0-e427ef138e39</xmpMM:DocumentID>
                  <xmpMM:InstanceID>uuid:4642285f-19a7-4222-985a-a056fd98cd1d</xmpMM:InstanceID>
                </rdf:Description>
              </rdf:RDF>
            </x:xmpmeta>
          </xmpPackage>
        </metadata>
      </featuresReport>
      <processingTime>00:00:00:038</processingTime>
    </job>
  </jobs>
  <summary jobs="1" failedJobs="0" valid="0" inValid="0" validExcep="0" features="1">
    <duration start="1485202087637" finish="1485202088042">00:00:00:405</duration>
  </summary>
</report>
```

### <a name="fonts"></a> Fonts
For this demonstration we'll use one of the veraPDF corpus files. First edit
your [config/features.xml](../config#features.xml) to read:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<featuresConfig>
    <enabledFeatures>
        <feature>FONT</feature>
    </enabledFeatures>
</featuresConfig>
```

then type:

<kbd>verapdf --off --extract corpus/veraPDF-corpus-staging/PDF_A-1b/6.3\ Fonts/6.3.6\ Font\ metrics/veraPDF\ test\ suite\ 6-3-6-t01-pass-a.pdf</kbd>

which should produce something like the following, although the font width
information has been removed:

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
        <item size="29813">
          <name>/home/cfw/verapdf/dev/corpus/veraPDF-corpus-staging/PDF_A-1b/6.3 Fonts/6.3.6 Font metrics/veraPDF test suite 6-3-6-t01-pass-a.pdf</name>
        </item>
        <featuresReport>
          <documentResources>
            <fonts>
              <font id="fntIndir11">
                <type>TrueType</type>
                <baseFont>SVIUCJ+TimesNewRomanPSMT</baseFont>
                <firstChar>32</firstChar>
                <lastChar>121</lastChar>
                <widths>...</widths>
                <encoding>WinAnsiEncoding</encoding>
                <fontDescriptor>
                  <fontName>SVIUCJ+TimesNewRomanPSMT</fontName>
                  <fontFamily>Times New Roman</fontFamily>
                  <fontStretch>Normal</fontStretch>
                  <fontWeight>400.0</fontWeight>
                  <fixedPitch>false</fixedPitch>
                  <serif>true</serif>
                  <symbolic>false</symbolic>
                  <script>false</script>
                  <nonsymbolic>true</nonsymbolic>
                  <italic>false</italic>
                  <allCap>false</allCap>
                  <smallCap>false</smallCap>
                  <forceBold>false</forceBold>
                  <fontBBox lly="-307.0" llx="-568.0" urx="2000.0" ury="1007.0"></fontBBox>
                  <italicAngle>0.0</italicAngle>
                  <ascent>1007.0</ascent>
                  <descent>-307.0</descent>
                  <leading>0.0</leading>
                  <capHeight>662.0</capHeight>
                  <xHeight>448.0</xHeight>
                  <stemV>80.0</stemV>
                  <stemH>0.0</stemH>
                  <averageWidth>0.0</averageWidth>
                  <maxWidth>0.0</maxWidth>
                  <missingWidth>0.0</missingWidth>
                  <embedded>true</embedded>
                </fontDescriptor>
              </font>
            </fonts>
          </documentResources>
        </featuresReport>
        <processingTime>00:00:00:413</processingTime>
      </job>
    </jobs>
  <summary jobs="1" failedJobs="0" valid="0" inValid="0" validExcep="0" features="1">
    <duration start="1485203090960" finish="1485203091479">00:00:00:519</duration>
  </summary>
</report>
```

### <a name="images"></a> Images
First edit your [config/features.xml](../config#features.xml) to read:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<featuresConfig>
    <enabledFeatures>
        <feature>IMAGE_XOBJECT</feature>
    </enabledFeatures>
</featuresConfig>
```
then type:

<kbd>verapdf --off --extract corpus/veraPDF-corpus-staging/PDF_A-1b/6.2\ Graphics/6.2.4\ Images/veraPDF\ test\ suite\ 6-2-4-t03-pass-a.pdf</kbd>

which will return:

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
      <item size="77857">
        <name>/home/cfw/verapdf/dev/corpus/veraPDF-corpus-staging/PDF_A-1b/6.2 Graphics/6.2.4 Images/veraPDF test suite 6-2-4-t03-pass-a.pdf</name>
      </item>
      <featuresReport>
        <documentResources>
          <xobjects>
            <xobject id="xobjIndir10" type="image">
              <width>800</width>
              <height>600</height>
              <bitsPerComponent>8</bitsPerComponent>
              <imageMask>false</imageMask>
              <interpolate>false</interpolate>
              <filters>
                <filter>FlateDecode</filter>
              </filters>
            </xobject>
          </xobjects>
        </documentResources>
      </featuresReport>
      <processingTime>00:00:00:084</processingTime>
    </job>
  </jobs>
  <summary jobs="1" failedJobs="0" valid="0" inValid="0" validExcep="0" features="1">
    <duration start="1485206502872" finish="1485206503041">00:00:00:169</duration>
  </summary>
</report>
```
