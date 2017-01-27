<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt">
    <sch:pattern>
        <sch:rule context="fonts/font/fontDescriptor">
            <sch:report test="fontName = 'UMBSME+AdobeGothicStd-Bold'">Adobe Gothic is present.</sch:report>
            <sch:assert test="fontName = 'UMBSME+AdobeGothicStd-Bold'">Only Adobe Gothic fonts are allowed.</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
