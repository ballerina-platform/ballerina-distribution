# Arrays

An array can be used to hold a set of values of the same type. The array type can be defined as `T[n]` in which `T` is the element type and `n` is the length of the array. `n` must be an integer literal or constant reference of type `int`. Optionally, you can create a variable-length array by defining an array without `n` as `T[]`.

The length of the array can be inferred from the context by defining the array as `T[*]`. The length of the array should be known in compile time.
An array of inferred length is also a fixed-length array, where the length is inferred from the right-hand side during initialization and cannot be changed afterward.

::: code arrays.bal :::

::: out arrays.out :::

## Related links
- [Manipulating an array `(lang.array)`](https://lib.ballerina.io/ballerina/lang.array)
- [Tuples](/learn/by-example/tuples)
- [Nested arrays](/learn/by-example/nested-arrays)
- [Filler values of a list](/learn/by-example/filler-values-of-a-list)
- [List sub typing](/learn/by-example/list-subtyping)
- [List equality](/learn/by-example/list-equality)
