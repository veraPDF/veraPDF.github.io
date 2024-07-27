---
layout: page
title: veraPDF Validation
---

The veraPDF validation engine implements the PDF/A and PDF/UA specification using formalizations of each "shall" statement (i.e., each requirement) in PDF/A-1, PDF/A-2, PDF/A-3, PDF/A-4, PDF/UA-1 and PDF/UA-2. These rules are implemented as XML documents known as Validation Profiles and are applied by veraPDF software at runtime. In cases of PDF/UA only machine verifiable checks are performed. See [Matterhorn protocol](https://pdfa.org/resource/the-matterhorn-protocol/) for more details on definitions of Machine and Human checkpoints.

[Read a little more about the veraPDF PDF/A validation model, rules and profiles.](./rules)

Validation rules
----------------
These pages distinctly identify each rule used by the software and provides details on the error(s) triggering a failure of the rule.

For each error the Object type, test condition, applicable specification and conformance level, as well as additional references, are provided.

Understandings based on the discussions of the PDF Validation Technical Working Group are included as appropriate.

[Rules for PDF/A-1](https://github.com/veraPDF/veraPDF-validation-profiles/wiki/PDFA-Part-1-rules/).

[Rules for PDF/A-2 and PDF/A-3](https://github.com/veraPDF/veraPDF-validation-profiles/wiki/PDFA-Parts-2-and-3-rules/).

[Rules for PDF/A-4](https://github.com/veraPDF/veraPDF-validation-profiles/wiki/PDFA-Part-4-rules/).

[Rules for PDF/UA-1](https://github.com/veraPDF/veraPDF-validation-profiles/wiki/PDFUA-Part-1-rules/).

[Rules for PDF/UA-2](https://github.com/veraPDF/veraPDF-validation-profiles/wiki/PDFUA-Part-2-rules/).
