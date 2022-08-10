# Arrays

`T[]` is an `array` of `T`. Arrays are mutable. `==` and `!=` on arrays is deep: two arrays are
equal if they have the same members in the same order. Ordering is lexicographical based on the
ordering of the members. Langlib `arr.length()` function gets the length; `arr.setLength(n)` sets the length.

::: code arrays.bal :::

::: out arrays.out :::