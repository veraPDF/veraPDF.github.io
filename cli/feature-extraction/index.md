## Feature extraction

### XMP metadata

To extract the XMP metadata from a PDF file you need to first edit your [config/features.xml](../config#features.xml) to read:

```xml
<feature>
    <name>XMP metadata</name>
    <enabled>true</enabled>
</feature>
```

then type:

<kbd>verapdf --off --extract adobe_supplement_iso32000.pdf</kbd>

to get the following output:

```
...
```

### Fonts

To extract font metrics from a PDF file first edit your [config/features.xml](../config#features.xml) to read:

```xml
<feature>
    <name>Fonts</name>
    <enabled>true</enabled>
</feature>
```

then type:

<kbd>verapdf --off --extract corpus/veraPDF-corpus-staging/PDF_A-1b/6.3\ Fonts/6.3.6\ Font\ metrics/veraPDF\ test\ suite\ 6-3-6-t01-pass-a.pdf</kbd>

which should produce something like the following, although the font width
information has been removed:

```
...
```

### Images

First edit your [config/features.xml](../config#features.xml) to read:

```xml
<feature>
    <name>Images</name>
    <enabled>true</enabled>
</feature>
```

then type:

<kbd>verapdf --off --extract corpus/veraPDF-corpus-staging/PDF_A-1b/6.2\ Graphics/6.2.4\ Images/veraPDF\ test\ suite\ 6-2-4-t03-pass-a.pdf</kbd>

which will return:

```
...
```