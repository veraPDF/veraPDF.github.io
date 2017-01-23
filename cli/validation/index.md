---
layout: page
title: veraPDF CLI Validation
---

{{ page.title }}
================

Validation using built in profiles
----------------------------------
The veraPDF software comes with eight sets of rules built in. These are known
as validation profiles and there's one for each level and part of the PDF/A
specification. You can list them by typing `verapdf -l` or `verapdf.bat --list` for Windows users. The `-l` and `--list` are interchangeable on all platforms.
You'll be greeted with:

    veraPDF supported PDF/A profiles:
      1a - PDF/A-1A validation profile
      1b - PDF/A-1B validation profile
      2a - PDF/A-2A validation profile
      2b - PDF/A-2B validation profile
      2u - PDF/A-2U validation profile
      3a - PDF/A-3A validation profile
      3b - PDF/A-3B validation profile
      3u - PDF/A-3U validation profile

You can specify a built in profile for validation using either the `-f` or
`--flavour` options followed by the 2 character profile code. To validate a
single PDF/A file from the corpus using the PDF/A-1B profile type
`verapdf -f 1b corpus/veraPDF-corpus-staging/PDF_A-1b/6.6\ Actions/6.6.1\ General/veraPDF\ test\ suite\ 6-6-1-t02-pass-a.pdf`.
