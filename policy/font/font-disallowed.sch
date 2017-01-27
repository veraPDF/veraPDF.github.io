<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt">
    <sch:pattern name="Disallow Adobe Gothic fonts.">
        <sch:rule context="fonts/font/fontDescriptor">
            <sch:assert test="not(contains(fontName,'AdobeGothicStd-Bold'))">Adobe Gothic Bold fonts are not allowed.</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
