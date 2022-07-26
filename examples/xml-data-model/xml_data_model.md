# XML data model

An `xml` value is a sequence representing the parsed content of an XML element. It consists of the four items below:

- Element
- Processing Instruction
- Comment
- Text

The element, processing instruction, and comment singletons correspond directly to the items in the XML information set. The text item corresponds to one or more character information items.

An XML document is an `xml` sequence with only one `element` and no `text`. An `element` item is mutable and consists of:

- `name`: type `string`
- `attributes`: type `map<string>`
- `children`: type `xml`

An XML `text` item is immutable.

- It has no identity: `==` is the same as `===`
- Consecutive `text` items never occur in an `xml` value: they are always merged

::: code xml_data_model.bal :::

::: out xml_data_model.out :::