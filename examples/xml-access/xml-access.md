# XML access

It is possible to access elements in xml

- x[i] gives i-th item (empty sequence if none).

- x.id accesses required attribute named id: result is error if there is no such attribute or if x is not a singleton.

- x?.id accesses optional attribute named id: result is () if there is no such attribute. Langlib lang.xml provides other operations.

::: code xml_access.bal :::

::: out xml_access.out :::

- [XML data model](/learn/by-example/xml-data-model/)
- [XML operations](/learn/by-example/xml-operations/)
