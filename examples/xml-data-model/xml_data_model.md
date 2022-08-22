# XML data model

An `xml` value is a sequence representing the parsed content of an XML element. An `xml` value has four kinds of items.

- The element, processing instruction, and comment singletons correspond directly to the items in the XML information set
- The text item corresponds to one or more character information items

XML document is an `xml` sequence with only one `element` and no `text`. An `element` item is mutable and consists of:

- name: type `string`
- attributes: type `map<string>`
- children: type `xml`

A `text` item is immutable.

- it has no identity: `==` is the same as `===`
- consecutive `text` items never occur in an `xml` value: they are always merged

::: code xml_data_model.bal :::

::: out xml_data_model.out :::