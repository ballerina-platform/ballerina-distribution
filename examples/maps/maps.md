# Maps

The `map<T>` type is a mapping from strings to `T`. The map syntax is similar to JSON. Maps are mutable. `foreach` can be used to iterate over the values of the map `m`, and `m.keys()`, which returns the keys as an array of strings can be used to iterate over the keys. `m[k]` gets the entry for `k`; `nil` if missing. Use `m.get(k)` when you know that there is an entry for `k`. Two maps are equal (`==`) if they have the same set of keys and the values for each key are equal.

::: code maps.bal :::

::: out maps.out :::

## Related links
- [Records](/learn/by-example#)
- [Foreach statement](/learn/by-example/foreach-statement/)