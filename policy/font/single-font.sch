<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt">
    <sch:pattern>
        <sch:rule context="fonts/font/fontDescriptor">
            <sch:report test="contains(fontName,'AdobeGothicStd-Bold')">Adobe Gothic Bold is present.</sch:report>
            <sch:assert test="contains(fontName,'AdobeGothicStd-Bold')">Only Adobe Gothic Bold fonts are allowed.</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
