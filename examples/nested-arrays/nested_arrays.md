# Nested arrays

Ballerina supports nested arrays where the element type is also an array type `T[p][q][r]`. Specifically, `T[p][q][r]` is interpreted as ( (T[r])[q])[p]. Hence, `T[p][q]` will construct an array of size `p` where the element type is `T[q]`. This is to be aligned with member access expression where v[i][j] will evaluate to a value of type T if and only if 0 ≤ i ≤ p and 0 ≤ j ≤ q.

::: code nested_arrays.bal :::

::: out nested_arrays.out :::

## Related links
- [Arrays - Ballerina by example](https://ballerina.io/learn/by-example/arrays)
- [Manipulating an array `(lang.array)` - Language library](https://lib.ballerina.io/ballerina/lang.array)
- [Tuples - Ballerina by example](https://ballerina.io/learn/by-example/tuples)
- [Filler values of a list - Ballerina by example](https://ballerina.io/learn/by-example/filler-values-of-a-list)
- [List sub typing - Ballerina by example](https://ballerina.io/learn/by-example/list-subtyping)
- [List equality - Ballerina by example](https://ballerina.io/learn/by-example/list-equality)
