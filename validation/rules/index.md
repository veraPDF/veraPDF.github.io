---
layout: page
title: Structure of validation rules
---

Validation profiles define a set of requirements - rules in a formal syntax - based on the generic veraPDF validation model.

The syntax of rules is based on the PDF model consisting of an object-oriented hierarchy of object types to be validated. Each object type contains a predefined inheritable set of simple properties and named links to lists of objects of other types. The complete description of the PDF model is located in [GitHub veraPDF-model repository](https://github.com/veraPDF/veraPDF-model).

For example, here is the definition of the `CosArray` type, representing Array objects in PDF documents:

<pre>
% PDF Array type
type CosArray extends CosObject {
	% number of elements in the array
	property size: Integer;
	% all objects contained in the array
	link elements: CosObject*;
}
</pre>

A validation profile that lists all requirements for each object type, or validation rules in formal terminology. Each rule is defined with a Boolean expression built from the object properties, elementary arithmetic, and Boolean operations. The complete set of all rules forming PDF/A validation profiles in located in [GitHub veraPDF-validation-profiles repository](https://github.com/veraPDF/veraPDF-validation-profiles).

Each of the rules is based on a specific "shall" requirement from one of the PDF/A specifications. Often, references to the relevant PDF specifications are included for extra details. For example, one of the requirements in PDF/A-1 is that any array shall contain at most 8191 elements. This is reflected as a Rule 6.1.12-5 in PDF/A-1b and PDF/A-1a validation profiles. It is formalized as a boolean test condition:

`size <= 8191`

This condition must be satisfied for all objects of type `CosArray` found in the PDF document.
