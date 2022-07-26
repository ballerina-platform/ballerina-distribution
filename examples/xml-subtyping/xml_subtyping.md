# XML subtyping

An `xml` value belongs to `xml:Element` if it consists of just an element
item. The same rule applies for `xml:Comment` and `xml:ProcessingInstruction`.
An `xml` value belongs to `xml:Text` if it consists of a text item or is 
empty.

An `xml` value belongs to the type `xml<T>` if each of its members belong
to `T`. Functions in the `lang.xml` module use this to provide safe and convenient typing. For example, `x.elements()` returns element items in `x` as type `xml<xml:Element>`. The `e.getName()` and `e.setName()` are defined when
`e` has the `xml:Element` type.

::: code xml_subtyping.bal :::

::: out xml_subtyping.out :::