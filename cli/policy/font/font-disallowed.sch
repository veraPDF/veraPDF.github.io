<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt">
    <sch:pattern name="Disallow Adobe Gothic fonts.">
        <sch:rule context="fonts/font/fontDescriptor">
            <sch:assert test="fontName != 'UMBSME+AdobeGothicStd-Bold'">Adobe Gothic fonts are not allowed.</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
