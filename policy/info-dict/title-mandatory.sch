<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt">
    <sch:pattern>
        <sch:rule context="featuresReport/informationDict">
            <sch:assert test="count(entry[@key='Title']) > 0">Title is presemnt.</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
