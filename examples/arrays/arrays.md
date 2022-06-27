# Arrays

When defining an array, `T[]` is an `array` of `T`. Arrays are mutable. When comparing arrays `==` and `!=` operators on arrays are deep: two arrays are equal if they have the same members in the same order. Ordering is lexicographical based on the ordering of the members. 

Langlib [`arr.length()`](https://lib.ballerina.io/ballerina/lang.array/0.0.0/functions#length) function can be used to get the array length. Users can also set the array length using [`arr.setLength(n)`](https://lib.ballerina.io/ballerina/lang.array/0.0.0/functions#setLength).

::: code arrays.bal :::

::: out arrays.out :::