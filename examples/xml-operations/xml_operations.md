# XML operations

Numerous operations including those listed below can be performed on `xml` values.

- `+` does concatenation
- `==` does a deep equality check
- `foreach` iterates over each item
- `x[i]` gives the `i-th` item (empty sequence if none)
- `x.id` accesses a required attribute named `id`. The result will be an error if there is no such attribute or if `x` is not a singleton.
- `x?.id` accesses an optional attribute named `id`. The result will be `()` if there is no such attribute.
- The [XML language library](https://lib.ballerina.io/ballerina/lang.xml/0.0.0) provides many other ways to manipulate XML. For example, an XML element can be mutated using the `e.setChildren(x)` lang library function.

::: code xml_operations.bal :::

::: out xml_operations.out :::