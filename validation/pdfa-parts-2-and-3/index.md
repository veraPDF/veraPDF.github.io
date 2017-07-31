---
layout: page
title: PDF/A-2 and PDF/A-3 validation rules
---

## Rule <a name="6.1.2-1"></a>6.1.2-1

### Requirement

>*The file header shall begin at byte zero and shall consist of "%PDF-1.n" followed by a single EOL marker, where 'n' is a single digit number between 0 (30h) and 7 (37h)*

### Error details

File header does not start at byte offset 0 or does not conform to Rule 6.1.2-1.

* Object type: `CosDocument`
* Test condition: `headerOffset == 0 && /^%PDF-1\.[0-7]$/.test(header)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.2-2"></a>6.1.2-2

### Requirement


>*The aforementioned EOL marker shall be immediately followed by a % (25h) character followed by at least four bytes, each of whose encoded byte values shall have a decimal value greater than 127.*


### Error details

Binary comment in the file header is missing or does not conform to Rule 6.1.2-2.

The presence of encoded character byte values greater than decimal 127 near the beginning of a file is used by various software tools and protocols to classify the file as containing 8-bit binary data that should be preserved during processing.


* Object type: `CosDocument`
* Test condition: `headerByte1 > 127 && headerByte2 > 127 && headerByte3 > 127 && headerByte4 > 127`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.3-1"></a>6.1.3-1

### Requirement

>*The file trailer dictionary shall contain the ID keyword whose value shall be File Identifiers as defined in ISO 32000-1:2008, 14.4*

### Error details

Missing ID in the document trailer.

Processing systems and documents may contain references to PDF files. Simply storing a file name, however, even in a platform-independent format, does not guarantee that the file can be found. Even if the file still exists and its name has not been changed, different server software applications may identify it in different ways. For example, servers running on DOS platforms must convert all file names to 8 characters and a 3-character extension; different servers may use different strategies for converting longer file names to this format.

External file referencescan be made more reliable by including a file identifier in the file itself and using it in addition to the normal platform-based file designation. File identifiers are defined by the optional ID entry in a PDF file’s trailer dictionary. The value of this entry is an array of two strings. The first string is a permanent identifier based on the contents of the file at the time it was originally created, and does not change when the file is incrementally updated. The second string is a changing identifier based on the file's contents at the time it was
last updated. When a file is first written, both identifiers are set to the same value. If both identifiers match when a file reference is resolved, it is very likely that the correct file has been found; if only the first identifier matches, then a different version of the correct file has been found.

* Object type: `CosDocument`
* Test condition: `lastID != null && lastID.length() > 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 14.4


## Rule <a name="6.1.3-2"></a>6.1.3-2

### Requirement

>*The keyword Encrypt shall not be used in the trailer dictionary.*

### Error details

Encrypt keyword is present in the trailer dictionary.

The explicit prohibition of the Encrypt keyword has the implicit effect of disallowing encryption and password-protected
access permissions.

* Object type: `CosTrailer`
* Test condition: `isEncrypted != true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.3-3"></a>6.1.3-3

### Requirement

>*No data can follow the last end-of-file marker except a single optional end-of-line marker as described in ISO 32000-1:2008, 7.5.5.*

### Error details

Data is present after the last end-of-file marker.

The trailer of a PDF file enables an application reading the file to quickly find the cross-reference table and certain special objects. Applications should read a PDF file from its end. The last line of the file contains only the end-of-file marker, %%EOF. Some PDF viewers require only that the %%EOF marker appear somewhere within the last 1024 bytes of the file. But having any data after %%EOF marker introduces risks that the PDF document might not be processed correctly.

* Object type: `CosDocument`
* Test condition: `postEOFDataSize == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 7.5.5


## Rule <a name="6.1.4-2"></a>6.1.4-2

### Requirement

>*The xref keyword and the cross-reference subsection header shall be separated by a single EOL marker.*

### Error details

Spacings after the 'xref' keyword in the cross reference table do conform to Rule 6.1.4-2.

The cross-reference table contains information that permits random access to indirect objects within the file, so that the entire file need not be read to locate any particular object. The table contains a one-line entry for each indirect object, specifying the location of that object within the body of the file.

The cross-reference table is the only part of a PDF file with a fixed format; this permits entries in the table to be accessed randomly. Any variations in this format, including unnecessary EOL markers may result in incorrect parsing of the cross-reference table and, thus, errors in reading the PDF document.

* Object type: `CosXRef`
* Test condition: `xrefEOLMarkersComplyPDFA`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.6-1"></a>6.1.6-1

### Requirement


>*Hexadecimal strings shall contain an even number of non-white-space characters.*


### Error details

A hexadecimal string contains odd number of non-white-space characters.

Strings in PDF documents may be written as a literal byte sequence or as a hexadecimal string; the latter is useful for including arbitrary binary data in a PDF file. A hexadecimal string is written as a sequence of hexadecimal digits (0–9 and either A–F or a–f) enclosed within angle brackets (< and >):

`<4E6F762073686D6F7A206B6120706F702E>`

Each pair of hexadecimal digits defines one byte of the string. White-space characters (such as space, tab, carriage return, line feed, and form feed) are ignored.

### veraPDF Technical Workgroup Notes

White-space characters are defined as NULL (00h), TAB (09h), LINE FEED (0Ah), FORM FEED (0Ch), CARRIGE RETURN (0Dh), SPACE (20h). They may appear within hexadecimal strings for formatting purposes:

`<4E6F 7620 7368 6D6F`
` 7A20 6B61 2070 6F70>`

* Object type: `CosString`
* Test condition: `(isHex != true) || hexCount % 2 == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.6-2"></a>6.1.6-2

### Requirement


>*A hexadecimal string is written as a sequence of hexadecimal digits (0-9 and either A-F or a-f).*


### Error details

Hexadecimal string contains non-white-space characters outside the range 0 to 9, A to F or a to f.

* Object type: `CosString`
* Test condition: `(isHex != true) || containsOnlyHex`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.7-1"></a>6.1.7-1

### Requirement


>*The value of the Length key specified in the stream dictionary shall match the number of bytes in the file following the LINE FEED (0Ah) character after the stream keyword and preceding the EOL marker before the endstream keyword.*


### Error details

Actual length of the stream does not match the value of the Length key in the Stream dictionary.

Every stream dictionary has a Length entry that indicates how many bytes of the PDF file are used for the stream's data. (If the stream has a filter, Length is the number of bytes of encoded data.) In addition, most filters are defined so that the data is self-limiting; that is, they use an encoding scheme in which an explicit end-of-data (EOD) marker delimits the extent of the data. Finally, streams are used to represent many objects from whose attributes a length can be inferred. All of these constraints must be consistent.

* Object type: `CosStream`
* Test condition: `isLengthCorrect`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.7-2"></a>6.1.7-2

### Requirement

>*The stream keyword shall be followed either by a CARRIAGE RETURN (0Dh) and LINE FEED (0Ah) character sequence or by a single LINE FEED (0Ah) character. The endstream keyword shall be preceded by an EOL marker.*


### Error details

Spacings of keywords 'stream' and 'endstream' do not conform to Rule 6.1.7-2.

These requirements remove potential ambiguity regarding the ending of stream content.

* Object type: `CosStream`
* Test condition: `streamKeywordCRLFCompliant == true && endstreamKeywordEOLCompliant == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.7-3"></a>6.1.7-3

### Requirement

>*A stream dictionary shall not contain the F, FFilter, or FDecodeParams keys.*

### Error details

A stream object dictionary contains one of the F, FFilter, or FDecodeParms keys.

These keys are used to point to document content external to the file. The explicit prohibition of these keys has the implicit effect of disallowing external content that can create external dependencies and complicate preservation efforts.

* Object type: `CosStream`
* Test condition: `F == null && FFilter == null && FDecodeParms == null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.7-4"></a>6.1.7-4

### Requirement


>*All standard stream filters listed in ISO 32000-1:2008, 7.4, Table 6 may be used, with the exception of LZWDecode. In addition, the Crypt filter shall not be used unless the value of the Name key in the decode parameters dictionary is Identity. Filters that are not listed in ISO 32000-1:2008, 7.4, Table 6 shall not be used.*

### Error details

The stream compression uses a filter not compiant to Rule 6.1.7-4.

The use of the LZW compression algorithm has been subject to intellectual property constraints. The Crypt filter is used to apply encryption and access control to the file.

* Object type: `CosFilter`
* Test condition: `
                internalRepresentation == "ASCIIHexDecode" ||  internalRepresentation == "ASCII85Decode" ||
                internalRepresentation == "FlateDecode" ||  internalRepresentation == "RunLengthDecode" ||
                internalRepresentation == "CCITTFaxDecode" ||  internalRepresentation == "JBIG2Decode" ||
                internalRepresentation == "DCTDecode" ||  internalRepresentation == "JPXDecode" ||
                (internalRepresentation == "Crypt" && decodeParms == "Identity")
            `
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.8-1"></a>6.1.8-1

### Requirement

>*Font names, names of colourants in Separation and DeviceN colour spaces, and structure type names, after expansion of character sequences escaped with a NUMBER SIGN (23h), if any, shall be valid UTF-8 character sequences.*


### Error details

The name object does not represent a correct Utf8 byte sequence.

As stated above, name objects shall be treated as atomic within a PDF file. Ordinarily, the bytes making up the name are never treated as text to be presented to a human user or to an application external to a conforming reader. However, occasionally the need arises to treat a name object as text, such as one that represents a font name, a colorant name in a separation or DeviceN colour space, or a structure type.

In such situations, the sequence of bytes (after expansion of NUMBER SIGN sequences, if any) should be interpreted according to UTF-8, a variable-length byte-encoded representation of Unicode in which the printable ASCII characters have the same representations as in ASCII. This enables a name object to represent text virtually in any natural language, subject to the implementation limit on the length of a name.

* Object type: `CosUnicodeName`
* Test condition: `isValidUtf8 == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 7.3.5


## Rule <a name="6.1.9-1"></a>6.1.9-1

### Requirement

>*The object number and generation number shall be separated by a single white-space character. The generation number and obj keyword shall be separated by a single white-space character. The object number and endobj keyword shall each be preceded by an EOL marker. The obj and endobj keywords shall each be followed by an EOL marker.*


### Error details

Spacings of object number and generation number or keywords 'obj' and 'endobj' do not conform to Rule 6.1.9-1.

The definition of an indirect object in a PDF file consists of its object number and generation number, followed by the value of the object itself bracketed between the keywords "obj" and "endobj". The requirements of this rule guarantee that the definition of an indirect object can be parsed unambiguously.

* Object type: `CosIndirect`
* Test condition: `spacingCompliesPDFA`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.10-1"></a>6.1.10-1

### Requirement

>*The value of the F key in the Inline Image dictionary shall not be LZW, LZWDecode, Crypt, a value not listed in ISO 32000-1:2008, Table 6, or an array containing any such value.*


### Error details

An inline image uses LZW, Crypt or one of the unknown filters.

Inline images are defined directly within the content stream in which it will be painted, rather than as separate objects. The use of LZW, Crypt and other non-standard compression imethods is also not permitted for such images.

* Object type: `CosIIFilter`
* Test condition: `
                internalRepresentation == "ASCIIHexDecode" ||  internalRepresentation == "ASCII85Decode" ||
                internalRepresentation == "FlateDecode" ||  internalRepresentation == "RunLengthDecode" ||
                internalRepresentation == "CCITTFaxDecode" || internalRepresentation == "DCTDecode" ||
                internalRepresentation == "AHx" || internalRepresentation == "A85" ||
                internalRepresentation == "Fl" || internalRepresentation == "RL" ||
                internalRepresentation == "CCF" || internalRepresentation == "DCT"
            `
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.12-1"></a>6.1.12-1

### Requirement


>*No keys other than UR3 and DocMDP shall be present in a permissions dictionary (ISO 32000-1:2008, 12.8.4, Table 258).*


### Error details

The document permissions dictionary contains keys other than UR3 and DocMDP.

* Object type: `PDPerms`
* Test condition: `containsOtherEntries == false`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO 32000-1:2008, 12.8.4


## Rule <a name="6.1.12-2"></a>6.1.12-2

### Requirement


>*If DocMDP is present, then the Signature References dictionary (ISO 32000-1:2008, 12.8.1, Table 253) shall not contain the keys DigestLocation, DigestMethod, and DigestValue.*


### Error details

The Signature References dictionary contains one of the keys DigestLocation, DigestMethod, or DigestValue in presence of DocMDP entry in the permissions dictionary.

These restrictions are present to ensure that functionality such as obsolete versions of the "User Rights" dictionary do not appear in a document conforming to ISO 19005-2 and ISO 19005-3.

* Object type: `PDSigRef`
* Test condition: `permsContainDocMDP == false || containsDigestEntries == false`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO 32000-1:2008, 12.8.1


## Rule <a name="6.1.13-1"></a>6.1.13-1

### Requirement

>*A conforming file shall not contain any integer greater than 2147483647. A conforming file shall not contain any integer less than -2147483648.*

### Error details

Integer value is out of range.

* Object type: `CosInteger`
* Test condition: `(intValue <= 2147483647) && (intValue >= -2147483648)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.13-2"></a>6.1.13-2

### Requirement

>*A conforming file shall not contain any real number outside the range of +/-3.403 x 10^38.*

### Error details

Real value is out of range.

* Object type: `CosReal`
* Test condition: `(realValue >= -3.403e+38) && (realValue <= 3.403e+38)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.13-3"></a>6.1.13-3

### Requirement


>*A conforming file shall not contain any string longer than 32767 bytes.*

### Error details

Maximum length of a String (32767) is exceeded.

* Object type: `CosString`
* Test condition: `value.length() < 32768`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.13-4"></a>6.1.13-4

### Requirement

>*A conforming file shall not contain any name longer than 127 bytes.*

### Error details

Maximum length of a Name (127) is exceeded.

* Object type: `CosName`
* Test condition: `internalRepresentation.length() <= 127`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.13-5"></a>6.1.13-5

### Requirement

>*A conforming file shall not contain any real number closer to zero than +/-1.175 x 10^(-38).*

### Error details

Non-zero real value is too close to 0.0.

* Object type: `CosReal`
* Test condition: `realValue == 0.0 || (realValue <= -1.175e-38) || (realValue >= 1.175e-38)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.13-7"></a>6.1.13-7

### Requirement

>*A conforming file shall not contain more than 8388607 indirect objects.*

### Error details

Maximum number of indirect objects (8,388,607) in a PDF file is exceeded.

* Object type: `CosDocument`
* Test condition: `nrIndirects <= 8388607`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.13-8"></a>6.1.13-8

### Requirement


>*A conforming file shall not nest q/Q pairs by more than 28 nesting levels.*


### Error details

Maximum depth of graphics state nesting (q and Q operators) is exceeded.

* Object type: `Op_q_gsave`
* Test condition: `nestingLevel <= 28`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.13-9"></a>6.1.13-9

### Requirement

>*A conforming file shall not contain a DeviceN colour space with more than 32 colourants.*

### Error details

Maximum number of DeviceN components (32) is exceeded

* Object type: `PDDeviceN`
* Test condition: `nrComponents <= 32`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.13-10"></a>6.1.13-10

### Requirement

>*A conforming file shall not contain a CID value greater than 65535.*

### Error details

Maximum value of a CID (65535) is exceeded.

* Object type: `CMapFile`
* Test condition: `maximalCID <= 65535`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.1.13-11"></a>6.1.13-11

### Requirement

>*The size of any of the page boundaries described in ISO 32000-1:2008, 14.11.2 shall not be less than 3 units in either direction, nor shall it be greater than 14 400 units in either direction.*

### Error details

One of the page boundaries is out of range (3-14400) in one of the directions.

* Object type: `CosBBox`
* Test condition: `Math.abs(top - bottom) >= 3 && Math.abs(top - bottom) <= 14400 && Math.abs(right - left) >= 3 && Math.abs(right - left) <= 14400`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.2-1"></a>6.2.2-1

### Requirement

>*Content streams shall not contain any operators not defined in ISO 32000-1 even if such operators are bracketed by the BX/EX compatibility operators.*

### Error details

A content stream contains an operator not defined in ISO 32000-1.

* Object type: `Op_Undefined`
* Test condition: `false`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.2-2"></a>6.2.2-2

### Requirement

>*A content stream that references other objects, such as images and fonts that are necessary to fully render or process the stream, shall have an explicitly associated Resources dictionary as described in ISO 32000-1:2008, 7.8.3.*


### Error details

A content stream references a named resource that is not defined in an explicitly associated Resources dictionary.

* Object type: `PDResource`
* Test condition: `isInherited == false`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO 32000-1:2008, 7.8.3

## Rule <a name="6.2.3-1"></a>6.2.3-1

### Requirement


>*The profile stream that is the value of the DestOutputProfile key shall either be an output profile (Device Class = "prtr") or a monitor profile (Device Class = "mntr"). The profiles shall have a colour space of either "GRAY", "RGB", or "CMYK".*


### Error details

The embedded PDF/A Output Intent colour profile has invalid header

* Object type: `ICCOutputProfile`
* Test condition: `(deviceClass == "prtr" || deviceClass == "mntr") && (colorSpace == "RGB " || colorSpace == "CMYK" || colorSpace == "GRAY") && version < 5.0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 14.11.5


## Rule <a name="6.2.3-2"></a>6.2.3-2

### Requirement


>*If a file's OutputIntents array contains more than one entry, as might be the case where a file is compliant with this part of ISO 19005 and at the same time with PDF/X-4 or PDF/E-1, then all entries that contain a	DestOutputProfile key shall have as the value of that key the same indirect object, which shall be a valid ICC profile stream.*

### Error details

File's OutputIntents array contains output intent dictionaries with non-matching destination output profiles.

* Object type: `PDOutputIntent`
* Test condition: `destOutputProfileIndirect == null || gOutputProfileIndirect == null || destOutputProfileIndirect == gOutputProfileIndirect`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.3-3"></a>6.2.3-3

### Requirement

>*The DestOutputProfileRef key, as defined in ISO 15930-7:2010, Annex A, shall not be present in any PDF/X OutputIntent.*


### Error details

The output intent dictionary contains entry DestOutputProfileRef, which is not permitted by PDF/A-2 and PDF/A-3 specifications.

* Object type: `PDOutputIntent`
* Test condition: `DestOutputProfileRef_size == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO15930-7:2010, Annex A


## Rule <a name="6.2.4.2-1"></a>6.2.4.2-1

### Requirement

>*The profile that forms the stream of an ICCBased colour space shall conform to ICC.1:1998-09, ICC.1:2001-12, ICC.1:2003-09 or ISO 15076-1.*

### Error details

The embedded ICC profile is either invalid or does not satisfy PDF 1.7 requirements.

* Object type: `ICCInputProfile`
* Test condition: `(deviceClass == "prtr" || deviceClass == "mntr" || deviceClass == "scnr" || deviceClass == "spac") &&
			(colorSpace == "RGB " || colorSpace == "CMYK" || colorSpace == "GRAY" || colorSpace == "LAB ") && version < 5.0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO 32000-1:2008, 8.6.5.5


## Rule <a name="6.2.4.2-2"></a>6.2.4.2-2

### Requirement

>*Overprint mode (as set by the OPM value in an ExtGState dictionary) shall not be one (1) when an ICCBased CMYK colour space is used for stroke and overprinting for stroke is set to true, or when ICCBased CMYK colour space is used for fill and overprinting for fill is set to true, or both.*

### Error details

Overprint mode (OPM) is set to 1 when an ICCBased CMYK colour space is used with enabled overprinting.

This prohibition avoids unpredictable overprinting behaviour when overprint mode is 1 if implicit colour conversion is applied as described in ISO 32000-1:2008, 8.6.7.

* Object type: `PDICCBasedCMYK`
* Test condition: `overprintFlag == false || OPM == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO 32000-1:2008, 8.6.7


## Rule <a name="6.2.4.3-2"></a>6.2.4.3-2

### Requirement


>*DeviceRGB shall only be used if a device independent DefaultRGB colour space has been set when the DeviceRGB colour space is used,
			or if the file has a PDF/A OutputIntent that contains an RGB destination profile.*


### Error details

DeviceRGB colour space is used without RGB output intent profile

* Object type: `PDDeviceRGB`
* Test condition: `gOutputCS != null && gOutputCS == "RGB "`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.4.3-3"></a>6.2.4.3-3

### Requirement


>*DeviceCMYK shall only be used if a device independent DefaultCMYK colour space has been set or if a DeviceN-based DefaultCMYK colour space has been set when the DeviceCMYK colour space is used or the file has a PDF/A OutputIntent that contains a CMYK destination profile.*


### Error details

DeviceCMYK colour space is used without CMYK output intent profile

* Object type: `PDDeviceCMYK`
* Test condition: `gOutputCS != null && gOutputCS == "CMYK"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.4.3-4"></a>6.2.4.3-4

### Requirement

>*DeviceGray shall only be used if a device independent DefaultGray colour space has been set when the DeviceGray colour space is used, or if a PDF/A OutputIntent is present.*

### Error details

DeviceGray colour space is used without an ICC output intent profile.

* Object type: `PDDeviceGray`
* Test condition: `gOutputCS != null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.4.4-1"></a>6.2.4.4-1

### Requirement

>*For any spot colour used in a DeviceN or NChannel colour space, an entry in the Colorants dictionary shall be present.*

### Error details

A colorant of the DeviceN color space is not defined in the Colorants dictionary

* Object type: `PDDeviceN`
* Test condition: `areColorantsPresent == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 8.6.6.5, Table 71


## Rule <a name="6.2.4.4-2"></a>6.2.4.4-2

### Requirement


>*All Separation arrays within a single PDF/A-2 file (including those in Colorants dictionaries) that have the same name shall have the same tintTransform and alternateSpace. In evaluating equivalence, the PDF objects shall be compared, rather than the computational result of the use of those PDF objects. Compression and whether or not an object is direct or indirect shall be ignored.*


### Error details

Several occurrances of a Separation colour space with the same name are not consistent

* Object type: `PDSeparation`
* Test condition: `areTintAndAlternateConsistent == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.5-1"></a>6.2.5-1

### Requirement

>*An ExtGState dictionary shall not contain the TR key.*

### Error details

An ExtGState dictionary contains the TR key.

* Object type: `PDExtGState`
* Test condition: `TR == null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.5-2"></a>6.2.5-2

### Requirement

>*An ExtGState dictionary shall not contain the TR2 key with a value other than Default.*

### Error details

An ExtGState dictionary contains the TR2 key with a value other than Default.

* Object type: `PDExtGState`
* Test condition: `TR2 == null || TR2 == "Default"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.5-3"></a>6.2.5-3

### Requirement

>*An ExtGState dictionary shall not contain the HTP key.*

### Error details

An ExtGState dictionary contains the HTP key.

* Object type: `PDExtGState`
* Test condition: `HTP_size == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.5-4"></a>6.2.5-4

### Requirement

>*All halftones in a conforming PDF/A-2 file shall have the value 1 or 5 for the HalftoneType key.*

### Error details

A Halftone has type other than 1 or 5

* Object type: `PDHalftone`
* Test condition: `HalftoneType != null && (HalftoneType == 1 || HalftoneType == 5)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.5-5"></a>6.2.5-5

### Requirement

>*Halftones in a conforming PDF/A-2 file shall not contain a HalftoneName key.*

### Error details

A Halftone dictionary contains the HalftoneName key

* Object type: `PDHalftone`
* Test condition: `HalftoneName == null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U


## Rule <a name="6.2.5-6"></a>6.2.5-6

### Requirement

>*The TransferFunction key in a halftone dictionary shall be used only as required by ISO 32000-1.*

### Error details

Invalid use of TransferFunction key in the Halftone dictionary.

This entry shall only be present if the Halftone dictionary is a component of a type 5 halftone and represents either a nonprimary or nonstandard primary colour component.

* Object type: `PDHalftone`
* Test condition: `colorantName == null || colorantName == 'Default' ||
 +			( (colorantName == 'Cyan' || colorantName == 'Magenta' || colorantName == 'Yellow' || colorantName == 'Black' || colorantName == 'Red' || 
 +			colorantName == 'Green' || colorantName == 'Blue') ? TransferFunction == null : TransferFunction != null)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 10.5.5.2, Table 130
  * ISO32000-1:2008, 10.5.5.6

## Rule <a name="6.2.6-1"></a>6.2.6-1

### Requirement

>*Where a rendering intent is specified, its value shall be one of the four values defined in ISO 32000-1:2008, Table 70: RelativeColorimetric, AbsoluteColorimetric, Perceptual or Saturation.*

### Error details

A rendering intent with non-standard value is used

* Object type: `CosRenderingIntent`
* Test condition: `internalRepresentation == "RelativeColorimetric" || internalRepresentation == "AbsoluteColorimetric" || internalRepresentation == "Perceptual" || internalRepresentation == "Saturation"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.8-1"></a>6.2.8-1

### Requirement

>*An Image dictionary shall not contain the Alternates key.*

### Error details

Alternates key is present in the Image dictionary.

* Object type: `PDXImage`
* Test condition: `Alternates_size == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.8-2"></a>6.2.8-2

### Requirement

>*An Image dictionary shall not contain the OPI key.*

### Error details

OPI key is present in the XObject dictionary.

* Object type: `PDXImage`
* Test condition: `OPI_size == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.8-3"></a>6.2.8-3

### Requirement

>*If an Image dictionary contains the Interpolate key, its value shall be false. For an inline image, the I key shall have a value of false.*


### Error details

The value of the Interpolate key in the Image dictionary is true

* Object type: `PDXImage`
* Test condition: `Interpolate == false`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.8.3-1"></a>6.2.8.3-1

### Requirement

>*The number of colour channels in the JPEG2000 data shall be 1, 3 or 4.*

### Error details

JPEG2000 image has number of colour channels different from 1, 3 or 4.

* Object type: `JPEG2000`
* Test condition: `nrColorChannels == 1 || nrColorChannels == 3 || nrColorChannels == 4`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.8.3-2"></a>6.2.8.3-2

### Requirement

>*If the number of colour space specifications in the JPEG2000 data is greater than 1, there shall be exactly one colour space specification that has the value 0x01 in the APPROX field.*

### Error details

The JPEG2000 image contains more than one colour specification with the best colour fidelity (value 0x01 in the APPROX field).

* Object type: `JPEG2000`
* Test condition: `nrColorSpaceSpecs == 1 || nrColorSpacesWithApproxField == 1`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.8.3-3"></a>6.2.8.3-3

### Requirement

>*The value of the METH entry in its 'colr' box shall be 0x01, 0x02 or 0x03. A conforming reader shall use only that colour space and shall ignore all other colour space specifications.*

### Error details

Colour specification of the JPEG2000 image has invalid specification method.

* Object type: `JPEG2000`
* Test condition: `colrMethod == 1 || colrMethod == 2 || colrMethod == 3`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.8.3-4"></a>6.2.8.3-4

### Requirement

>*JPEG2000 enumerated colour space 19 (CIEJab) shall not be used.*

### Error details

JPEG2000 image uses enumerated colour space 19 (CIEJab), which is not allowed in PDF/A.

* Object type: `JPEG2000`
* Test condition: `colrEnumCS == null || colrEnumCS != 19`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.8.3-5"></a>6.2.8.3-5

### Requirement

>*The bit-depth of the JPEG2000 data shall have a value in the range 1 to 38. All colour channels in the JPEG2000 data shall have the same bit-depth.*

### Error details

JPEG2000 image has bit-depth parameters outside of the permitted rante 1 to 38.

* Object type: `JPEG2000`
* Test condition: `bpccBoxPresent == false && (bitDepth >= 1 && bitDepth <= 38) `
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.9-1"></a>6.2.9-1

### Requirement

>*A form XObject dictionary shall not contain any of the following: - the OPI key; - the Subtype2 key with a value of PS; - the PS key.*

### Error details

The form XObject dictionary contains a PS key, or a Subtype2 key with value PS, or an OPI key.

* Object type: `PDXForm`
* Test condition: `(Subtype2 == null || Subtype2 != "PS") && PS_size == 0 && OPI_size == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.9-2"></a>6.2.9-2

### Requirement

>*A conforming file shall not contain any reference XObjects.*

### Error details

The document contains a reference XObject (Ref key in the form XObject dictionary).

* Object type: `PDXForm`
* Test condition: `Ref_size == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.9-3"></a>6.2.9-3

### Requirement

>*A conforming file shall not contain any PostScript XObjects.*

### Error details

The document contains a PostScript XObject.

* Object type: `PDXObject`
* Test condition: `Subtype != "PS"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.10-1"></a>6.2.10-1

### Requirement

>*Only blend modes that are specified in ISO 32000-1:2008 shall be used for the value of the BM key in an extended graphic state dictionary.*

### Error details

The document uses the blend mode not defined in ISO 32000-1:2008.

* Object type: `PDExtGState`
* Test condition: `BM == null || BM == "Normal" || BM == "Compatible" || BM == "Multiply" || BM == "Screen" || BM == "Overlay" || BM == "Darken" ||
			BM == "Lighten" || BM == "ColorDodge" || BM == "ColorBurn" || BM == "HardLight" || BM == "SoftLight" || BM == "Difference" || BM == "Exclusion" ||
			BM == "Hue" || BM == "Saturation" || BM == "Color" || BM == "Luminosity"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 11.3.5, Tables 136-137


## Rule <a name="6.2.10-2"></a>6.2.10-2

### Requirement

>*If the document does not contain a PDF/A OutputIntent, then all Page objects that contain transparency shall include the Group key, and the attribute dictionary that forms the value of that Group key shall include a CS entry whose value shall be used as the default blending colour space.*

### Error details

The page contains transparent objects with no blending colour space defined.

PDF transparency (as described in ISO 32000-1:2008, Clause 11) may be used in a PDF/A-2 and PDF/A-3 file. This requirement ensures that there is always an explicitly defined transparency blending space
specified for any content which has associated transparency.

* Object type: `PDPage`
* Test condition: `gOutputCS != null || containsGroupCS == true || containsTransparency == false`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 11.3.4


## Rule <a name="6.2.11.2-1"></a>6.2.11.2-1

### Requirement

>*All fonts and font programs used in a conforming file, regardless of rendering mode usage, shall conform to the provisions in ISO 32000-1:2008, 9.6 and 9.7, as well as to the font specifications referenced by these provisions.*

>*Type - name - (Required) The type of PDF object that this dictionary describes; must be Font for a font dictionary*

### Error details

A Font dictionary has missing or invalid Type entry

* Object type: `PDFont`
* Test condition: `Type == "Font"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 9.6.2.1, Table 111
  * ISO32000-1:2008, 9.6.5, Table 112
  * ISO32000-1:2008, 9.7.4.1, Table 117
  * ISO32000-1:2008, 9.7.6.1, Table 121

## Rule <a name="6.2.11.2-2"></a>6.2.11.2-2

### Requirement


>*All fonts and font programs used in a conforming file, regardless of rendering mode usage, shall conform to the provisions in ISO 32000-1:2008, 9.6 and 9.7, as well as to the font specifications referenced by these provisions.*

>Subtype - name - (Required) The type of font; must be "Type1" for Type 1 fonts, "MMType1" for multiple master fonts, "TrueType" for TrueType fonts "Type3" for Type 3 fonts, "Type0" for Type 0 fonts and "CIDFontType0" or "CIDFontType2" for CID fonts*


### Error details

A Font dictionary has missing or invalid Subtype entry.

* Object type: `PDFont`
* Test condition: `Subtype == "Type1" || Subtype == "MMType1" || Subtype == "TrueType" || Subtype == "Type3" || Subtype == "Type0"
			|| Subtype == "CIDFontType0" || Subtype == "CIDFontType2"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 9.6.2.1, Table 111
  * ISO32000-1:2008, 9.6.2.3
  * ISO32000-1:2008, 9.6.3
  * ISO32000-1:2008, 9.6.5, Table 112
  * ISO32000-1:2008, 9.7.4.1, Table 117
  * ISO32000-1:2008, 9.7.6.1, Table 121


## Rule <a name="6.2.11.2-3"></a>6.2.11.2-3

### Requirement

>*All fonts and font programs used in a conforming file, regardless of rendering mode usage, shall conform to the provisions in ISO 32000-1:2008, 9.6 and 9.7, as well as to the font specifications referenced by these provisions.*

>*BaseFont - name - (Required) The PostScript name of the font*


### Error details

A BaseFont entry is missing or has invalid type

* Object type: `PDFont`
* Test condition: `Subtype == "Type3" || fontName != null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 9.6.2.1, Table 111
  * ISO32000-1:2008, 9.7.4.1, Table 117
  * ISO32000-1:2008, 9.7.6.1, Table 121

## Rule <a name="6.2.11.2-4"></a>6.2.11.2-4

### Requirement

>*All fonts and font programs used in a conforming file, regardless of rendering mode usage, shall conform to the provisions in ISO 32000-1:2008, 9.6 and 9.7, as well as to the font specifications referenced by these provisions.*

>*FirstChar - integer - (Required except for the standard 14 fonts) The first character code defined in the font's Widths array*


### Error details

A non-standard simple font dictionary has missing or invalid FirstChar entry

* Object type: `PDSimpleFont`
* Test condition: `isStandard == true || FirstChar != null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 9.6.2.1, Table 111
  * ISO32000-1:2008, 9.6.5, Table 112

## Rule <a name="6.2.11.2-5"></a>6.2.11.2-5

### Requirement


>*All fonts and font programs used in a conforming file, regardless of rendering mode usage, shall conform to the provisions in ISO 32000-1:2008, 9.6 and 9.7, as well as to the font specifications referenced by these provisions.*

>*FirstChar - integer - (Required except for the standard 14 fonts) The first character code defined in the font's Widths array*

### Error details

A non-standard simple font dictionary has missing or invalid LastChar entry

* Object type: `PDSimpleFont`
* Test condition: `isStandard == true || LastChar != null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 9.6.2.1, Table 111
  * ISO32000-1:2008, 9.6.5, Table 112

## Rule <a name="6.2.11.2-6"></a>6.2.11.2-6

### Requirement


>*All fonts and font programs used in a conforming file, regardless of rendering mode usage, shall conform to the provisions in ISO 32000-1:2008, 9.6 and 9.7, as well as to the font specifications referenced by these provisions.*

>*Widths - array - (Required except for the standard 14 fonts; indirect reference preferred) An array of (LastChar - FirstChar + 1) widths*

### Error details

Font Widths array is missing or has invalid size.

* Object type: `PDSimpleFont`
* Test condition: `isStandard == true || (Widths_size != null && Widths_size == LastChar - FirstChar + 1)`
* Specification: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 9.6.2.1, Table 111
  * ISO32000-1:2008, 9.6.5, Table 112  

  
## Rule <a name="6.2.11.2-7"></a>6.2.11.2-7

### Requirement

>*All fonts and font programs used in a conforming file, regardless of rendering mode usage, shall conform to the provisions in ISO 32000-1:2008, 9.6 and 9.7, as well as to the font specifications referenced by these provisions.*

>*The only valid embedded font programs are PostScript Type1, CFF (compact font format) Type1, TrueType or OpenType.*

### Error details

The subtype of the embedded font program is determined as follows. 

* PostScript Type1, if referenced by /FontFile key in the font descriptor dictionary
* TrueType, if referenced by /FontFile2 key in the font descriptor dictionary
* Type1 (or CID Type1), if referenced by /FontFile3 key. 

In the latter case the Subtype key in the referenced stream object is used to determine the exact font type. The only valid values of this key in PDF 1.4 are:
* Type1C - Type1–equivalent font program represented in the Compact Font Format (CFF); 
* CIDFontType0C - Type0 CIDFont program represented in the Compact Font Format (CFF);
* OpenType - OpenType font program.

* Object type: `PDFont`
* Test condition: `fontFileSubtype == null || fontFileSubtype == 'Type1C' || fontFileSubtype == 'CIDFontType0C' || fontFileSubtype == 'OpenType'`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 9.9, Table 126
  * Adobe Technical Note #5176, The Compact Font Format Specification
  * OpenType Font Specification 1.4, December 2004, Microsoft
  

## Rule <a name="6.2.11.3-1"></a>6.2.11.3-1

### Requirement

>*For any given composite (Type 0) font within a conforming file, the CIDSystemInfo entry in its CIDFont dictionary and its Encoding dictionary shall have the following relationship. If the Encoding key in the Type 0 font dictionary is Identity-H or Identity-V, any values of Registry, Ordering, and Supplement may be used in the CIDSystemInfo entry of the CIDFont. Otherwise, the corresponding Registry and Ordering strings in both CIDSystemInfo dictionaries shall be identical, and the value of the Supplement key in the CIDSystemInfo dictionary of the CIDFont shall be greater than or equal to the Supplement key in the CIDSystemInfo dictionary of the CMap.*


### Error details

CiDSystemInfo entries the CIDFont and CMap dictionaries of a Type 0 font are not compatible.

* Object type: `PDType0Font`
* Test condition: `cmapName == "Identity-H" || cmapName == "Identity-V" || (areRegistryOrderingCompatible == true && isSupplementCompatible == true)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.11.3-2"></a>6.2.11.3-2

### Requirement


>*ISO 32000-1:2008, 9.7.4, Table 117 requires that all embedded Type 2 CIDFonts in the CIDFont dictionary shall contain a CIDToGIDMap entry that shall be a stream mapping from CIDs to glyph indices or the name Identity, as described in ISO 32000-1:2008, 9.7.4, Table 117.*


### Error details

A Type 2 CIDFont dictionary has missing or invalid CIDToGIDMap entry.

* Object type: `PDCIDFont`
* Test condition: `Subtype != "CIDFontType2" || CIDToGIDMap != null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 9.7.4, Table 117


## Rule <a name="6.2.11.3-3"></a>6.2.11.3-3

### Requirement


>*All CMaps used within a PDF/A-2 file, except those listed in ISO 32000-1:2008, 9.7.5.2, Table 118, shall be embedded in that file as described in ISO 32000-1:2008, 9.7.5.*


### Error details

A non-standard CMap is not embedded

* Object type: `PDCMap`
* Test condition: `CMapName == "Identity-H" || CMapName == "Identity-V" || CMapName == "GB-EUC-H" || CMapName == "GB-EUC-V" ||
			CMapName == "GBpc-EUC-H" || CMapName == "GBpc-EUC-V" || CMapName == "GBK-EUC-H" || CMapName == "GBK-EUC-V" ||
			CMapName == "GBKp-EUC-H" || CMapName == "GBKp-EUC-V" || CMapName == "GBK2K-EUC-H" || CMapName == "GBK2K-EUC-V" ||
			CMapName == "UniGB-UCS2-H" || CMapName == "UniGB-UCS2-V" || CMapName == "UniGB-UFT16-H" || CMapName == "UniGB-UFT16-V" ||
			CMapName == "B5pc-H" || CMapName == "B5pc-V" || CMapName == "HKscs-B5-H" || CMapName == "HKscs-B5-V" ||
			CMapName == "ETen-B5-H" || CMapName == "ETen-B5-V" || CMapName == "ETenms-B5-H" || CMapName == "ETenms-B5-V" ||
			CMapName == "CNS-EUC-H" || CMapName == "CNS-EUC-V" || CMapName == "UniCNS-UCS2-H" || CMapName == "UniCNS-UCS2-V" ||
			CMapName == "UniCNS-UFT16-H" || CMapName == "UniCNS-UTF16-V" || CMapName == "83pv-RKSJ-H" || CMapName == "90ms-RKSJ-H" ||
			CMapName == "90ms-RKSJ-V" || CMapName == "90msp-RKSJ-H" || CMapName == "90msp-RKSJ-V" || CMapName == "90pv-RKSJ-H" ||
			CMapName == "Add-RKSJ-H" || CMapName == "Add-RKSJ-V" || CMapName == "EUC-H" || CMapName == "EUC-V" ||
			CMapName == "Ext-RKSJ-H" || CMapName == "Ext-RKSJ-V" || CMapName == "H" || CMapName == "V" ||
			CMapName == "UniJIS-UCS2-H" || CMapName == "UniJIS-UCS2-V" || CMapName == "UniJIS-UCS2-HW-H" || CMapName == "UniJIS-UCS2-HW-V" ||
			CMapName == "UniJIS-UTF16-H" || CMapName == "UniJIS-UTF16-V" || CMapName == "KSC-EUC-H" || CMapName == "KSC-EUC-V" ||
			CMapName == "KSCms-UHC-H" || CMapName == "KSCms-UHC-V" || CMapName == "KSCms-UHC-HW-H" || CMapName == "KSCms-UHC-HW-V" ||
			CMapName == "KSCpc-EUC-H" || CMapName == "UniKS-UCS2-H" || CMapName == "UniKS-UCS2-V" || CMapName == "UniKS-UTF16-H" || CMapName == "UniKS-UTF16-V" ||
			embeddedFile_size == 1`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 9.7.5.2, Table 118


## Rule <a name="6.2.11.3-4"></a>6.2.11.3-4

### Requirement


>*For those CMaps that are embedded, the integer value of the WMode entry in the CMap dictionary shall be identical to the WMode value in the embedded CMap stream.*

### Error details

WMode entry in the embedded CMap and in the CMap dictionary are not identical.

* Object type: `CMapFile`
* Test condition: `WMode == dictWMode`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.11.3-5"></a>6.2.11.3-5

### Requirement

>*A CMap shall not reference any other CMap except those listed in ISO 32000-1:2008, 9.7.5.2, Table 118.*

### Error details

A CMap references another non-standard CMap

* Object type: `PDReferencedCMap`
* Test condition: `CMapName == "Identity-H" || CMapName == "Identity-V" || CMapName == "GB-EUC-H" || CMapName == "GB-EUC-V" ||
			CMapName == "GBpc-EUC-H" || CMapName == "GBpc-EUC-V" || CMapName == "GBK-EUC-H" || CMapName == "GBK-EUC-V" ||
			CMapName == "GBKp-EUC-H" || CMapName == "GBKp-EUC-V" || CMapName == "GBK2K-EUC-H" || CMapName == "GBK2K-EUC-V" ||
			CMapName == "UniGB-UCS2-H" || CMapName == "UniGB-UCS2-V" || CMapName == "UniGB-UFT16-H" || CMapName == "UniGB-UFT16-V" ||
			CMapName == "B5pc-H" || CMapName == "B5pc-V" || CMapName == "HKscs-B5-H" || CMapName == "HKscs-B5-V" ||
			CMapName == "ETen-B5-H" || CMapName == "ETen-B5-V" || CMapName == "ETenms-B5-H" || CMapName == "ETenms-B5-V" ||
			CMapName == "CNS-EUC-H" || CMapName == "CNS-EUC-V" || CMapName == "UniCNS-UCS2-H" || CMapName == "UniCNS-UCS2-V" ||
			CMapName == "UniCNS-UFT16-H" || CMapName == "UniCNS-UTF16-V" || CMapName == "83pv-RKSJ-H" || CMapName == "90ms-RKSJ-H" ||
			CMapName == "90ms-RKSJ-V" || CMapName == "90msp-RKSJ-H" || CMapName == "90msp-RKSJ-V" || CMapName == "90pv-RKSJ-H" ||
			CMapName == "Add-RKSJ-H" || CMapName == "Add-RKSJ-V" || CMapName == "EUC-H" || CMapName == "EUC-V" ||
			CMapName == "Ext-RKSJ-H" || CMapName == "Ext-RKSJ-V" || CMapName == "H" || CMapName == "V" ||
			CMapName == "UniJIS-UCS2-H" || CMapName == "UniJIS-UCS2-V" || CMapName == "UniJIS-UCS2-HW-H" || CMapName == "UniJIS-UCS2-HW-V" ||
			CMapName == "UniJIS-UTF16-H" || CMapName == "UniJIS-UTF16-V" || CMapName == "KSC-EUC-H" || CMapName == "KSC-EUC-V" ||
			CMapName == "KSCms-UHC-H" || CMapName == "KSCms-UHC-V" || CMapName == "KSCms-UHC-HW-H" || CMapName == "KSCms-UHC-HW-V" ||
			CMapName == "KSCpc-EUC-H" || CMapName == "UniKS-UCS2-H" || CMapName == "UniKS-UCS2-V" || CMapName == "UniKS-UTF16-H" || CMapName == "UniKS-UTF16-V"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 9.7.5.2, Table 118

## Rule <a name="6.2.11.4-1"></a>6.2.11.4-1

### Requirement

>*The font programs for all fonts used for rendering within a conforming file shall be embedded within that file, as defined in ISO 32000-1:2008, 9.9.*

### Error details

The font program is not embedded

* Object type: `PDFont`
* Test condition: `Subtype == "Type3" || Subtype == "Type0" || fontFile_size == 1`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 9.9


## Rule <a name="6.2.11.4-2"></a>6.2.11.4-2

### Requirement


>*Embedded fonts shall define all glyphs referenced for rendering within the conforming file. A font referenced for use solely in rendering mode 3 is therefore not rendered and is thus exempt from the embedding requirement.*


### Error details

Not all glyphs referenced for rendering are present in the embedded font program.

* Object type: `Glyph`
* Test condition: `renderingMode == 3 || isGlyphPresent == null || isGlyphPresent == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.11.4-3"></a>6.2.11.4-3

### Requirement

>*If the FontDescriptor dictionary of an embedded Type 1 font contains a CharSet string, then it shall list the character names of all glyphs present in the font program, regardless of whether a glyph in the font is referenced or used by the PDF or not.*

### Error details

A CharSet entry in the Descriptor dictionary of a Type1 font incorrectly lists glyphs present in the font program.

* Object type: `PDType1Font`
* Test condition: `CharSet == null || charSetListsAllGlyphs == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.11.4-4"></a>6.2.11.4-4

### Requirement

>*If the FontDescriptor dictionary of an embedded CID font contains a CIDSet stream, then it shall identify all CIDs which are present in the font program, regardless of whether a CID in the font is referenced or used by the PDF or not.*

### Error details

A CID Font subset does not define CIDSet entry in its Descriptor dictionary

* Object type: `PDCIDFont`
* Test condition: `CIDSet_size == 0 || cidSetListsAllGlyphs == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.11.5-1"></a>6.2.11.5-1

### Requirement

>*For every font embedded in a conforming file and used for rendering, the glyph width information in the font dictionary and in the embedded  font program shall be consistent.*

### Error details

Glyph width information in the embedded font program is not consistent with the Widths entry of the font dictionary.

* Object type: `Glyph`
* Test condition: `renderingMode == 3 || isWidthConsistent == null || isWidthConsistent == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.11.6-1"></a>6.2.11.6-1

### Requirement

>*For all non-symbolic TrueType fonts used for rendering, the embedded TrueType font program shall contain one or several non-symbolic cmap entries such that all necessary glyph lookups can be carried out.*

### Error details

The embedded font program for a non-symbolic TrueType font does not contain any cmap subtables.

* Object type: `TrueTypeFontProgram`
* Test condition: `isSymbolic == true || nrCmaps >= 1`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.11.6-2"></a>6.2.11.6-2

### Requirement

>*No non-symbolic TrueType font shall define a Differences array unless all of the glyph names in the Differences array are listed in the Adobe Glyph List and the embedded font program contains at least the Microsoft Unicode (3,1 - Platform ID=3, Encoding ID=1) encoding in the 'cmap' table.*

### Error details

A non-symbolic TrueType font has encoding different from MacRomanEncoding or WinAnsiEncoding, or the glyphs in the Differences array can not be mapped to the embedded font glyphs via the Adobe Glyph List.

* Object type: `PDTrueTypeFont`
* Test condition: `isSymbolic == true || (Encoding == "MacRomanEncoding" || Encoding == "WinAnsiEncoding") ||
				(Encoding == "Custom" && differencesAreUnicodeCompliant == true)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.11.6-3"></a>6.2.11.6-3

### Requirement

>*Symbolic TrueType fonts shall not contain an Encoding entry in the font dictionary.*

### Error details

A symbolic TrueType font specifies an Encoding entry in its dictionary.

* Object type: `PDTrueTypeFont`
* Test condition: `isSymbolic == false || Encoding == null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.11.6-4"></a>6.2.11.6-4

### Requirement

>*Symbolic TrueType fonts shall not contain an Encoding entry in the font dictionary, and the 'cmap' table in the embedded font program shall either contain exactly one encoding or it shall contain, at least, the Microsoft Symbol (3,0 - Platform ID=3, Encoding ID=0) encoding.*


### Error details

The embedded font program for a symbolic TrueType font contains more than one cmap subtable.

* Object type: `TrueTypeFontProgram`
* Test condition: `isSymbolic == false || nrCmaps == 1 || cmap30Present == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.2.11.7-1"></a>6.2.11.7-1

### Requirement

>*The Font dictionary of all fonts shall define the map of all used character codes to Unicode values, either via a ToUnicode entry, or other mechanisms as defined in ISO 19005-2:2011, 6.2.11.7.2.*

### Error details

The font does not define Unicode character map or some glyphs have invalid Unicode value.

The font dictionary of all fonts, regardless of their rendering mode usage, shall include a ToUnicode entry whose value is a CMap stream object that maps character codes for at least all referenced glyphs
to Unicode values, as described in ISO 32000-1:2008, 9.10.3, unless the font meets at least one of the following four conditions:
- fonts that use the predefined encodings MacRomanEncoding, MacExpertEncoding or WinAnsiEncoding;
- Type 1 and Type 3 fonts where the glyph names of the glyphs referenced are all contained in the Adobe Glyph List or the set of named characters in the Symbol font, as defined in ISO 32000-1:2008, Annex D;
- Type 0 fonts whose descendant CIDFont uses the Adobe-GB1, Adobe-CNS1, Adobe-Japan1 or Adobe-Korea1 character collections.
- Non-symbolic TrueType fonts.

* Object type: `Glyph`
* Test condition: `toUnicode != null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, U

## Rule <a name="6.2.11.7-2"></a>6.2.11.7-2

### Requirement

>*The Unicode values specified in the ToUnicode CMap shall all be greater than zero (0), but not equal to either U+FEFF or U+FFFE.*

### Error details

This requirement ensures that the Unicode value of the glyph complies to the Unicode specification, which reserves several code values as markers for auxiliary purposes.

* Object type: `Glyph`
* Test condition: `toUnicode == null || (toUnicode.indexOf("\u0000") == -1 && toUnicode.indexOf("\uFFFE") == -1 && toUnicode.indexOf("\uFEFF")  == -1)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, U

## Rule <a name="6.2.11.7-3"></a>6.2.11.7-3

### Requirement

>*For any character, regardless of its rendering mode, that is mapped to a code or codes in the Unicode Private Use Area (PUA), an ActualText entry as described in ISO 32000-1:2008, 14.9.4 shall be present for this character or a sequence of characters of which such a character is a part.*

### Error details

This requirement ensures that the Unicode values of the glyph have well-defined semantic meaning, or otherwise this Unicode value is provided via so-called Actual text mechanism.

* Object type: `Glyph`
* Test condition: `unicodePUA == false || actualTextPresent == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A
* Additional references:
  * ISO 32000-1:2008, 14.9.4

## Rule <a name="6.2.11.8-1"></a>6.2.11.8-1

### Requirement

>*A PDF/A-2 compliant document shall not contain a reference to the .notdef glyph from any of the text showing operators, regardless of text rendering mode, in any content stream.*

### Error details

The document contains a reference to the .notdef glyph.

* Object type: `Glyph`
* Test condition: `name != ".notdef"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.3.1-1"></a>6.3.1-1

### Requirement

>*Annotation types not defined in ISO 32000-1 shall not be permitted. Additionally, the 3D, Sound, Screen and Movie types shall not be permitted.*

### Error details

Unknown or not permitted annotation type.

* Object type: `PDAnnot`
* Test condition: `Subtype == "Text" || Subtype == "Link" || Subtype == "FreeText" || Subtype == "Line" ||
			Subtype == "Square" || Subtype == "Circle" || Subtype == "Polygon" || Subtype == "PolyLine" ||
			Subtype == "Highlight" || Subtype == "Underline" ||	Subtype == "Squiggly" || Subtype == "StrikeOut" ||
			Subtype == "Stamp" || Subtype == "Caret" || Subtype == "Ink" || Subtype == "Popup" ||
			Subtype == "FileAttachment" || Subtype == "Widget" || Subtype == "PrinterMark" || Subtype == "TrapNet" ||
			Subtype == "Watermark" || Subtype == "Redact"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * PDF 1.4 Reference, 12.5.6.1, Table 169


## Rule <a name="6.3.2-1"></a>6.3.2-1

### Requirement

>*Except for annotation dictionaries whose Subtype value is Popup, all annotation dictionaries shall contain the F key.*

### Error details

A dictionary of a non-Popup annotation does not contain F key.

* Object type: `PDAnnot`
* Test condition: `Subtype == "Popup" || F != null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.3.2-2"></a>6.3.2-2

### Requirement

>*If present, the F key's Print flag bit shall be set to 1 and its Hidden, Invisible, ToggleNoView, and NoView flag bits shall be set to 0.*

### Error details

One of the annotation flags Hidden, Invisible, ToggleNoView, or NoView is set to 1, or the Print flag is set to 0.

* Object type: `PDAnnot`
* Test condition: `F == null || ((F & 1) == 0 && (F & 2) == 0 && (F & 4) == 4 && (F & 32) == 0 && (F & 256) == 0)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.3.2-3"></a>6.3.2-3

### Requirement

>*Text annotations should set the NoZoom and NoRotate flag bits of the F key to 1.*


### Error details

Text annotation has one of the flags NoZoom or NoRotate set to 0.

* Object type: `PDAnnot`
* Test condition: `Subtype != "Text" || (F != null && (F & 8) == 8 && (F & 16) == 16)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.3.3-1"></a>6.3.3-1

### Requirement

>*Every annotation (including those whose Subtype value is Widget, as used for form fields), except for the two cases listed below, shall have at least one appearance dictionary: annotations where the value of the Rect key consists of an array where value 1 is equal to value 3 and value 2 is equal to value 4;  annotations whose Subtype value is Popup or Link.*


### Error details

An annotation does not contain an appearance dictionary.

* Object type: `PDAnnot`
* Test condition: `(width == 0 && height ==0) || Subtype == "Popup" || Subtype == "Link" || AP != null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.3.3-2"></a>6.3.3-2

### Requirement

>*For all annotation dictionaries containing an AP key, the appearance dictionary that it defines as its value shall contain only the N key. If an annotation dictionary's Subtype key has a value of Widget and its FT key has a	value of Btn, the value of the N key shall be an appearance subdictionary, otherwise the value of the N key shall be an appearance stream.*

### Error details

Annotation's appearance dictionary contains entries other than N or the N entry has an invalid type.

* Object type: `PDAnnot`
* Test condition: `AP == null || ( AP == "N" && ( ((Subtype != "Widget" || FT != "Btn") && N_type == "Stream")
			|| (Subtype == "Widget" && FT == "Btn" && N_type == "Dict") ) )`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.4.1-1"></a>6.4.1-1

### Requirement

>*A Widget annotation dictionary or Field dictionary shall not contain the A or AA keys.*

### Error details

A Widget annotation contains either A or AA entry.

* Object type: `PDAnnot`
* Test condition: `Subtype != "Widget" || (A_size == 0 && AA_size == 0)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.4.1-2"></a>6.4.1-2

### Requirement

>*A Widget annotation dictionary or Field dictionary shall not contain the A or AA keys.*

### Error details

A Form field dictionary contains the AA entry.

* Object type: `PDFormField`
* Test condition: `AA_size == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.4.1-3"></a>6.4.1-3

### Requirement

>*The NeedAppearances flag of the interactive form dictionary shall either not be present or shall be false.*

### Error details

The interactive form dictionary contains the NeedAppearances flag with value true.

* Object type: `PDAcroForm`
* Test condition: `NeedAppearances == null || NeedAppearances == false`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.4.2-1"></a>6.4.2-1

### Requirement

>*The document's interactive form dictionary that forms the value of the AcroForm key in the document's Catalog of a PDF/A-2 file, if present, shall not contain the XFA key.*

### Error details

The interactive form dictionary contains the XFA key.

* Object type: `PDAcroForm`
* Test condition: `XFA_size == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.4.2-2"></a>6.4.2-2

### Requirement

>*A document's Catalog shall not contain the NeedsRendering key.*

### Error details

A document's Catalog contains NeedsRendering flag set to true.

* Object type: `CosDocument`
* Test condition: `NeedsRendering == false`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.4.3-1"></a>6.4.3-1

### Requirement

>*When computing the digest for the file, it shall be computed over the entire file, including the signature dictionary but excluding the PDF Signature itself.*

### Error details

ByteRanbe array of the digital signature does not cover the entire file (excluding the PDF Signature itself).

As permitted by ISO 32000-1:2008, 12.8.1, a PDF/A-2 or PDF/A-3 conforming file may contain document, certifying or user rights signatures. Such signatures shall be specified in the PDF through the use of signature fields
in accordance with ISO 32000-1:2008, 12.7.4.5.

This makes normative a recommendation in ISO 32000-1:2008, 12.8.1. By restricting the ByteRange entry this way, it ensures that there are no bytes in the PDF that are not
covered by the digest, other than the PDF signature itself.

* Object type: `PDSignature`
* Test condition: `doesByteRangeCoverEntireDocument == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO 19005-2:2011, Annex B
  * ISO 32000-1:2008, 12.8.1
  * ISO 32000-1:2008, 12.7.4.5


## Rule <a name="6.4.3-2"></a>6.4.3-2

### Requirement


>*The PDF Signature (a DER-encoded PKCS#7 binary data object) shall be placed into the Contents entry of the signature dictionary. The PKCS#7 object shall conform to the PKCS#7 specification in RFC 2315. At minimum, it shall include the signer's X.509 signing certificate and there shall only be a single signer (e.g. a single "SignerInfo" structure) in the PDF Signature.*


### Error details

The DER-encoded PKCS#7 binary data object representing a PDF Signature does not conform to PDF/A-2 requirements

* Object type: `PKCSDataObject`
* Test condition: `signingCertificatePresent == true && SignerInfoCount == 1`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO 19005-2:2011, Annex B
  * RFC 2315,


## Rule <a name="6.5.1-1"></a>6.5.1-1

### Requirement

>*The Launch, Sound, Movie, ResetForm, ImportData, Hide, SetOCGState, Rendition, Trans, GoTo3DView and JavaScript actions shall not be permitted. Additionally, the deprecated set-state and noop actions shall not be permitted.*


### Error details

Unknown or not permitted action type.

* Object type: `PDAction`
* Test condition: `S == "GoTo" || S == "GoToR" || S == "GotToE" || S == "Thread" || S == "URI" || S == "Named" || S == "SubmitForm"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 12.6.4.1, Table 198


## Rule <a name="6.5.1-2"></a>6.5.1-2

### Requirement

>*Named actions other than NextPage, PrevPage, FirstPage, and LastPage shall not be permitted.*

### Error details

Unknown or not permitted named action.

* Object type: `PDNamedAction`
* Test condition: `N == "NextPage" || N == "PrevPage" || N == "FirstPage" || N == "LastPage"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO32000-1:2008, 12.6.4.11, Table 211


## Rule <a name="6.5.2-1"></a>6.5.2-1

### Requirement

>*The document's Catalog shall not include an AA entry for an additional-actions dictionary.*

### Error details

The document catalog dictionary contains an additional-actions dictionary (AA entry)

* Object type: `PDDocument`
* Test condition: `AA_size == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.5.2-2"></a>6.5.2-2

### Requirement

>*The Page dictionary shall not include an AA entry for an additional-actions dictionary.*

### Error details

The Page dictionary contains an additional-actions dictionary (AA entry).

* Object type: `PDPage`
* Test condition: `AA_size == 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.2.1-1"></a>6.6.2.1-1

### Requirement

>*The Catalog dictionary of a conforming file shall contain the Metadata key whose value is a metadata stream as defined in ISO 32000-1:2008, 14.3.2.*

### Error details

The document catalog dictionary doesn't contain metadata key.

* Object type: `PDDocument`
* Test condition: `metadata_size == 1`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * ISO 32000-1, 14.3.2


## Rule <a name="6.6.2.1-2"></a>6.6.2.1-2

### Requirement

>*The bytes attribute shall not be used in the header of an XMP packet.*

### Error details

The XMP Package contains bytes attribute.

* Object type: `XMPPackage`
* Test condition: `bytes == null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.2.1-3"></a>6.6.2.1-3

### Requirement

>*The encoding attribute shall not be used in the header of an XMP packet.*

### Error details

The XMP Package contains encoding attribute.

* Object type: `XMPPackage`
* Test condition: `encoding == null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.2.1-4"></a>6.6.2.1-4

### Requirement

>*All metadata streams present in the PDF shall conform to the XMP Specification. All content of all XMP packets shall be well-formed, as defined by Extensible Markup Language (XML) 1.0 (Third Edition), 2.1, and the RDF/XML Syntax Specification (Revised).*

### Error details

A metadata stream is serialized icorrectly and can not be parsed.

* Object type: `XMPPackage`
* Test condition: `isSerializationValid`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
* Additional references:
  * XMP Specification September 2005,
  * Extensible Markup Language (XML) 1.0 (Third Edition), 04 February 2004, 2.1
  * RDF/XML Syntax Specification (Revised), 10 February 2004,

## Rule <a name="6.6.2.3-1"></a>6.6.2.3-1

### Requirement

>*Extension schemas shall be specified using the PDF/A extension schema container schema defined in 6.6.2.3.3. All fields described in each of the tables in 6.6.2.3.3 shall be present in any extension schema container schema.*


### Error details

An extension schema object contains fields not defined by the specification.

* Object type: `ExtensionSchemaObject`
* Test condition: `containsUndefinedFields == false`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.2.3-2"></a>6.6.2.3-2

### Requirement

>*The extension schema container schema uses the namespace URI "http://www.aiim.org/pdfa/ns/extension/". The required schema namespace prefix is pdfaExtension. pdfaExtension:schemas - Bag Schema - Description of extension schemas*


### Error details

Invalid syntax of the extension schema container.

* Object type: `ExtensionSchemasContainer`
* Test condition: `isValidBag == true && prefix == "pdfaExtension"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.2.3-3"></a>6.6.2.3-3

### Requirement

>*The Schema type is an XMP structure containing the definition of an extension schema. The field namespace URI is "http://www.aiim.org/pdfa/ns/schema#". The required field namespace prefix is pdfaSchema. The Schema type includes the following fields: pdfaSchema:schema (Text), pdfaSchema:namespaceURI (URI), pdfaSchema:prefix (Text), pdfaSchema:property (Seq Property), pdfaSchema:valueType (Seq ValueType).*

### Error details

Invalid Extension Schema definition.

* Object type: `ExtensionSchemaDefinition`
* Test condition: `(isSchemaValidText == true && schemaPrefix == "pdfaSchema") &&
			(isNamespaceURIValidURI == true && ( (ExtensionSchemaProperties_size == 0 && namespaceURIPrefix == null) || namespaceURIPrefix == "pdfaSchema" ) ) &&
			(isPrefixValidText == true && (prefixPrefix == null || prefixPrefix == "pdfaSchema") ) &&
			(isPropertyValidSeq == true && (propertyPrefix == null || propertyPrefix == "pdfaSchema") ) &&
			(isValueTypeValidSeq == true && (valueTypePrefix == null || valueTypePrefix == "pdfaSchema") )`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.2.3-4"></a>6.6.2.3-4

### Requirement

>*The Property type defined is an XMP structure containing the definition of a schema property. The field namespace URI is "http://www.aiim.org/pdfa/ns/property#". The required field namespace prefix is pdfaProperty. The Property type includes the following fields: pdfaProperty:name (Text), pdfaProperty:valueType (Open Choice of Text), pdfaProperty:category (Closed Choice of Text), pdfaProperty:description (Text).*


### Error details

Invalid extension schema Property type definition

* Object type: `ExtensionSchemaProperty`
* Test condition: `(isNameValidText == true && namePrefix == "pdfaProperty" ) &&
			(isValueTypeValidText == true && isValueTypeDefined == true && valueTypePrefix == "pdfaProperty" ) &&
			(isCategoryValidText == true && (category == "external" || category == "internal") && categoryPrefix == "pdfaProperty") &&
			(isDescriptionValidText == true && descriptionPrefix == "pdfaProperty" )`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.2.3-5"></a>6.6.2.3-5

### Requirement

>*The ValueType type is an XMP structure containing the definition of all property value types used by embedded extension schemas that are not defined in the XMP Specification. The field namespace URI is "http://www.aiim.org/pdfa/ns/type#". The required field namespace prefix is pdfaType. The ValueType type includes the following fields: pdfaType:type (Text), pdfaType:namespaceURI (URI), pdfaType:prefix (Text), pdfaType:description (Text), pdfaType:field (Seq Field).*

### Error details

Invalid extension schema ValueType type definition.

* Object type: `ExtensionSchemaValueType`
* Test condition: `(isTypeValidText == true && typePrefix == "pdfaType" ) &&
			(isNamespaceURIValidURI == true && namespaceURIPrefix == "pdfaType" ) &&
			(isPrefixValidText == true && prefixPrefix == "pdfaType" ) &&
			(isDescriptionValidText == true && descriptionPrefix == "pdfaType" ) &&
			(isFieldValidSeq == true && (fieldPrefix == null || fieldPrefix == "pdfaType") )`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.2.3-6"></a>6.6.2.3-6

### Requirement

>*The Field type defined in Table 6 is an XMP structure containing the definition of a property value type field. The field namespace URI is "http://www.aiim.org/pdfa/ns/field#". The required field namespace prefix is pdfaField. The Field type contains the following fields:	pdfaField:name (Text), pdfaField:valueType (Open Choice of Text), pdfaField:description (Text).*

### Error details

Invalid extension schema Field type definition

* Object type: `ExtensionSchemaField`
* Test condition: `(isNameValidText == true && namePrefix == "pdfaField" ) &&
			(isValueTypeValidText == true && isValueTypeDefined == true && valueTypePrefix == "pdfaField" ) &&
			(isDescriptionValidText == true && descriptionPrefix == "pdfaField" )`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.2.3-7"></a>6.6.2.3-7

### Requirement

>*All properties specified in XMP form shall use either the predefined schemas defined in the XMP Specification, ISO 19005-1 or this part of ISO 19005, or any extension schemas that comply with 6.6.2.3.2.*


### Error details

An XMP property is either not not pre-defined, is not defined in any extension schema, or has invalid type.

* Object type: `XMPProperty`
* Test condition: `(isPredefinedInXMP2005 == true || isDefinedInMainPackage == true || isDefinedInCurrentPackage == true) && isValueTypeCorrect == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.4-1"></a>6.6.4-1

### Requirement

>*The PDF/A version and conformance level of a file shall be specified using the PDF/A Identification extension schema.*

### Error details

The document metadata stream doesn't contains PDF/A Identification Schema.

* Object type: `MainXMPPackage`
* Test condition: `Identification_size == 1`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.4-2"></a>6.6.4-2

### Requirement

>*The value of pdfaid:part shall be the part number of ISO 19005 to which the file conforms.*

### Error details

The "part" property of the PDF/A Identification Schema is does not match the PDF/A profile part number.

* Object type: `PDFAIdentification`
* Test condition: `part == 2` (for PDF/A-2); `part == 3` (for PDF/A-3).
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.4-3"></a>6.6.4-3

### Requirement


>*A Level A conforming file shall specify the value of pdfaid:conformance as A. A Level B conforming file shall specify the value of pdfaid:conformance as B. A Level U conforming file shall specify the value of pdfaid:conformance as U.*


### Error details

The "conformance" property of the PDF/A Identification Schema does not confirm the PDF/A profile level.

* Object type: `PDFAIdentification`
* Test condition (Level B): `conformance == "B" || conformance == "U" || conformance == "A"`
* Test condition (Level U): `conformance == "U" || conformance == "A"`
* Test condition (Level A): `conformance == "A"`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.6.4-4"></a>6.6.4-4

### Requirement


>*The PDF/A Identification schema defined in Table 8 uses the namespace URI "http://www.aiim.org/pdfa/ns/id/". The required schema namespace prefix is pdfaid. It contains the following fields: pdfaid:part (Open Choice of Integer), pdfaid:amd (Open Choice of Text), pdfaid:corr (Open Choice of Text), pdfaid:conformance (Open Choice of Text).*


### Error details

A property of the PDF/A Identification Schema has an invalid namespace prefix.

* Object type: `PDFAIdentification`
* Test condition: `partPrefix == "pdfaid" && conformancePrefix == "pdfaid" &&
			(amdPrefix == null || amdPrefix == "pdfaid") &&
			(corrPrefix == null || corrPrefix == "pdfaid")`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.7.2-1"></a>6.7.2-1

### Requirement


>*The document catalog dictionary shall include a MarkInfo dictionary containing an entry, Marked, whose value shall be true.*


### Error details

/Marked entry of the MarkInfo dictionary is not present in the document catalog or is set to false.

* Object type: `CosDocument`
* Test condition: `Marked == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A
* Additional references:
  * ISO 32000-1, 14.7.1


## Rule <a name="6.7.3-1"></a>6.7.3-1

### Requirement


>*The logical structure of the conforming file shall be described by a structure hierarchy rooted in the StructTreeRoot entry of the document's Catalog dictionary, as described in ISO 32000-1:2008, 14.7.*


### Error details

StructTreeRoot entry is not present in the document catalog

* Object type: `PDDocument`
* Test condition: `StructTreeRoot_size == 1`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A
* Additional references:
  * ISO 32000-1:2008, 14.7


## Rule <a name="6.7.3-2"></a>6.7.3-2

### Requirement


>*All non-standard structure types shall be mapped to the nearest functionally equivalent standard type, as defined in ISO 32000-1:2008, 14.8.4, in the role map dictionary of the structure tree root.*


### Error details

Non-standard structure type is not mapped to a standard type.

* Object type: `PDStructElem`
* Test condition: `standardType != null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A
* Additional references:
  * ISO 32000-1:2008, 14.8.4
  

## Rule <a name="6.7.4-1"></a>6.7.4-1

### Requirement

>*If the Lang entry is present in the document's Catalog dictionary or in a structure element dictionary or property list, its value shall be a language identifier as described in ISO 32000-1:2008, 14.9.2.*

### Error details

A language identifier shall either be the empty text string, to indicate that the language is unknown, or a Language Tag as defined in RFC 3066, Tags for the Identification of Languages.

* Object type: `CosLang`
* Test condition: `value == '' || /^[a-zA-Z]{1,8}(-[a-zA-Z0-9]{1,8})*$/.test(value)`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A
* Additional references:
  * ISO 32000-1:2008, 14.9.2
  * RFC 3066, Tags for the Identification of Languages


## Rule <a name="6.8-1"></a>6.8-1

### Requirement

>*The MIME type of an embedded file, or a subset of a file, shall be specified using the Subtype key of the file specification dictionary. If the MIME type is not known, the "application/octet-stream" shall be used.*

### Error details

The MIME type information (Subtype entry) of an embedded file is missing or invalid.

* Object type: `EmbeddedFile`
* Test condition: `Subtype != null && /^[-\w+\.]+\/[-\w+\.]+$/.test(Subtype)`
* Specifications: ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.8-2"></a>6.8-2

### Requirement

>*The file specification dictionary for an embedded file shall contain the F and UF keys.*

### Error details

The file specification dictionary for an embedded file does not contain either F or EF key.

* Object type: `CosFileSpecification`
* Test condition: `EF_size == 0 || (F != null && UF != null)`
* Specifications: ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.8-3"></a>6.8-3

### Requirement

>*In order to enable identification of the relationship between the file specification dictionary and the content that is referring to it, a new (required) key has been defined and its presence (in the dictionary) is required.*

### Error details

The file specification dictionary for an embedded file does not contain the AFRelationship key.

* Object type: `CosFileSpecification`
* Test condition: `AFRelationship != null`
* Specifications: ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.8-4"></a>6.8-4

### Requirement

>*The additional information provided for associated files as well as the usage requirements for associated files indicate the relationship	between the embedded file and the PDF document or the part of the PDF document with which it is associated.*

### Error details

The embedded file is not associated with the PDF document or any of its parts. An embedded file can be associated (via the /AF entry) with the complete PDF document, 
or a page, an image, a form XObject, an annotation, a structure element or a marked content sequence in the page content. 

* Object type: `CosFileSpecification`
* Test condition: `isAssociatedFile == true`
* Specifications: ISO 19005-3:2012, Annex E
* Levels: A, B, U


## Rule <a name="6.9-1"></a>6.9-1

### Requirement

>*Each optional content configuration dictionary that forms the value of the D key, or that is an element in the array that forms the value of the Configs key in the OCProperties dictionary, shall contain the Name key.*

### Error details

Missing or empty Name entry of the optional content configuration dictionary.

* Object type: `PDOCConfig`
* Test condition: `Name != null && Name.length() > 0`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.9-2"></a>6.9-2

### Requirement

>*Each optional content configuration dictionary shall contain the Name key, whose value shall be unique amongst all optional content configuration dictionaries within the PDF/A-2 file.*

### Error details

Optional content configuration dictionary has duplicated name.

* Object type: `PDOCConfig`
* Test condition: `hasDuplicateName == false`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.9-3"></a>6.9-3

### Requirement

>*If an optional content configuration dictionary contains the Order key, the array which is the value of this Order key shall contain references to all OCGs in the conforming file.*

### Error details

Not all optional content groups are present in the Order entry of the optional content configuration dictionary.

* Object type: `PDOCConfig`
* Test condition: `doesOrderContainAllOCGs == true`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.9-4"></a>6.9-4

### Requirement

>*The AS key shall not appear in any optional content configuration dictionary.*

### Error details

AS key is present in the optional content configuration dictionary.

* Object type: `PDOCConfig`
* Test condition: `AS == null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.10-1"></a>6.10-1

### Requirement

>*There shall be no AlternatePresentations entry in the document's name dictionary.*

### Error details

The document's name dictionary contains the AlternatePresentations entry.

* Object type: `PDDocument`
* Test condition: `containsAlternatePresentations == false`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.10-2"></a>6.10-2

### Requirement

>*There shall be no PresSteps entry in any Page dictionary.*

### Error details

A Page dictionary contains the PresSteps entry.

* Object type: `PDPage`
* Test condition: `containsPresSteps == false`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U

## Rule <a name="6.11-1"></a>6.11-1

### Requirement

>*The document catalog shall not contain the Requirements key.*

### Error details

The document catalog contains the Requirements key.

* Object type: `CosDocument`
* Test condition: `Requirements == null`
* Specifications: ISO 19005-2:2011, ISO 19005-3:2012
* Levels: A, B, U
