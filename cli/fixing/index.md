---
layout: page
title: veraPDF CLI Metadata Fixing
---

veraPDF can optionally fix PDF/A issues related to document metadata provided that there are no other PDF/A issues detected. This includes:
- adding document-level XMP metadata if it is missing
- adding PDF/A identification to the already existing XMP metadata, if there are no other PDF/A issues detected and the document will become PDF/A compliant after this fix
- removing PDF/A identification from the XMP metadata if it is resent, but the document does not conform to the declared PDF/A flavor
- synchronizing metadata properties between document Info dictionary and theXMP metadata (only for PDF/A-1)

The following CLI arguments control the behavior of the Metadata fixer:
- `--fixmetadata` enables Metadata fixing functionality
- `--prefix` sets file name prefix for any fixed files
- `--savefolder` sets output directory for any fixed files
