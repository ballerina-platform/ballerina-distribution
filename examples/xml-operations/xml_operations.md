# XML operations

`+` does concatenation.
`==` does deep equals.
`foreach` iterates over each item.
`x[i]` gives i-th item (empty sequence if none).
`x.id` accesses required attribute named `id`:
result is error if there is no such attribute
or if x is not a singleton.
`x?.id` accesses optional attribute named `id`:
result is () if there is no such attribute.
Langlib lang.xml provides other operations.
Mutate an element using `e.setChildren(x)`.

::: code xml_operations.bal :::

::: out xml_operations.out :::