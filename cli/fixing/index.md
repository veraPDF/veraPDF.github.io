---
layout: page
title: veraPDF CLI Metadata Fixing
---

veraPDF can optionally fix issues related to document metadata provided that there are no other PDF/A or PDF/UA issues detected. This includes:
- adding document-level XMP metadata if it is missing
- adding PDF/A or PDF/UA identification to the already existing XMP metadata, if there are no other PDF/A (or PDF/UA) issues detected and the document will become PDF/A (or PDF/UA) compliant after this fix
- removing PDF/A or PDF/UA identification from the XMP metadata if it is present, but the document does not conform to the declared PDF/A (or PDF/UA) flavour
- synchronizing metadata properties between document Info dictionary and the XMP metadata (only for PDF/A-1)

The following CLI arguments control the behavior of the Metadata fixer:
- `--fixmetadata` enables Metadata fixing functionality
- `--prefix` sets file name prefix for any fixed files
- `--savefolder` sets output directory for any fixed files
