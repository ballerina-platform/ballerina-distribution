# XML access

It is possible to access elements in XML.

- `x[i]` gives the `i`-th item (empty sequence if none).

- `x.id` accesses the required attribute named `id`: the result is an error if there is no such attribute or if `x` is not a singleton.

- `x?.id` accesses an optional attribute named `id`: the result is `()` if there is no such attribute. The `lang.xml` langlib provides the other operations.

::: code xml_access.bal :::

::: out xml_access.out :::

## Related links
- [XML data model](/learn/by-example/xml-data-model/)
- [XML operations](/learn/by-example/xml-operations/)
- [`lang.xml` - Module documentation](https://lib.ballerina.io/ballerina/lang.xml/latest/)
