# Ordering

`order by` clause in query expression can be used to sort elements in a collection. Ordering works consistently with `<`, `<=`, `>`, `>=` operators. Some comparisons involving `()` and float `NaN` are considered unordered. So if these unordered types are encountered in the query, they will be returned as the last elements of the ordered collection.

Syntax to write order by clause is `order by expression orderDirection`. Order direction can be `ascending` or `descending`.

::: code ordering.bal :::

::: out ordering.out :::

## Related links
- [Manipulating an array `(lang.array)` - Language library](https://lib.ballerina.io/ballerina/lang.array)
