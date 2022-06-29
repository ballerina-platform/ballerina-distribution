# XML operations

- `+` does concatenation.
- `==` does deep equals.
- `foreach` iterates over each item.
- `x[i]` gives i-th item (empty sequence if none).
- `x.id` accesses required attribute named `id`. The result will be an error if there is no such attribute
or if x is not a singleton.
- `x?.id` accesses optional attribute named `id`. The result will be `()` if there is no such attribute.
- Langlib lang.xml provides other operations. For an example, using langlib function `e.setChildren(x)` an XML element can be mutated.

::: code xml_operations.bal :::

::: out xml_operations.out :::