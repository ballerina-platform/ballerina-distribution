# XML access

It is possible to access both elements and attributes in XML. 
The `x[i]` syntax retrieves the i-th item in the XML sequence. 
The `x.id` syntax accesses a required attribute, while `x?.id` 
accesses an optional attribute. The `lang.xml` langlib provides 
the other operations.

- `x[i]` gives the `i`-th item (empty sequence if none).

- `x.id` accesses the required attribute named `id`: the result is an error if there is no such attribute or if `x` is not a singleton.

- `x?.id` accesses an optional attribute named `id`: the result is `()` if there is no such attribute. 

::: code xml_access.bal :::

::: out xml_access.out :::

## Related links
- [XML data model](/learn/by-example/xml-data-model/)
- [XML operations](/learn/by-example/xml-operations/)
- [`lang.xml` - Module documentation](https://lib.ballerina.io/ballerina/lang.xml/latest/)
