# XML templates

`xml` values can be constructed using an XML template expression.
Phase 2 processing for `xml` template tag parses strings using 
the XML 1.0 Recommendation's grammar for content (what XML allows 
between a start-tag and an end-tag).
Interpolated expressions can be in content (`xml` or `string` values) 
or in attribute values (`string` values).

::: code xml_templates.bal :::

::: out xml_templates.out :::