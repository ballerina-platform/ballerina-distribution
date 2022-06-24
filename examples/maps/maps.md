# Maps

The `map<T>` type is a mapping from strings to `T`. The map syntax is similar to JSON. Maps are mutable.
`m[k]` is an "lvalue". `foreach` will iterate over the values of the `map`. `m[k]` gets entry for `k`; `nil` if
missing. Use `m.get(k)` when you know that there is an entry for `k`. `m.keys()` can be used
to iterate over keys to get the keys as an `array` of strings. `==` and `!=` on maps is deep. Two maps
are equal if they have the same set of keys and the values for each key are equal.

::: code maps.bal :::

::: out maps.out :::