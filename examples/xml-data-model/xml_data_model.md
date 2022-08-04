# XML data model

An `xml` value is a sequence representing the parsed content of an XML element. <br></br>
An `xml` value has four kinds of items.
<ul>
<li>The element, processing instruction, and comment singletons correspond directly to the items in the XML information set</li>
<li>The text item corresponds to one or more character information items</li>
</ul>
//<br></br>
<p>XML document is an `xml` sequence with only one `element` and no `text`. An `element` item is mutable
and consists of:</p>
<ul>
<li>name: type `string`</li>
<li>attributes: type `map<string>`</li>
<li>children: type `xml`</li>
</ul>
//<br></br>
<p>A `text` item is immutable.</p>
<ul>
<li>it has no identity: `==` is the same as `===`</li>
<li>consecutive `text` items never occur in an `xml` value: they are always merged</li>
</ul>

::: code xml_data_model.bal :::

::: out xml_data_model.out :::