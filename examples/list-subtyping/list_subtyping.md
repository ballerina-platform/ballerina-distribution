# List subtyping

An array with a length is a subtype of an array of same member type descriptor without a length. Two arrays with the same length or  without a length is a subtype of the other if the member type descriptor is a subtype of the other. Tuple type `T` is a subtype of  type `T1` if the set of values allowed in `T` is a sub set of values allowed in `T1`

::: code list_subtyping.bal :::

::: out list_subtyping.out :::

## Related links
- [Tuples](/learn/by-example/tuples)
- [Arrays](/learn/by-example/arrays)
- [List equality](/learn/by-example/list-equality)
