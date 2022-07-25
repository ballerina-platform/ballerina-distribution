# XML templates

`xml` values can be constructed using an XML template expression. In Phase 2 of the processing, the `xml` template tag parses the strings using the XML 1.0 recommendation's grammar for the content (what XML allows between a start-tag and an end-tag). Interpolated expressions can be in the content (`xml` or `string` values) or in attribute values (`string` values).

::: code xml_templates.bal :::

::: out xml_templates.out :::