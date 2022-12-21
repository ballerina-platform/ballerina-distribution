# Sort iterable objects

`order by` clause in query expression can be used to sort elements in a collection. Ordering works consistently with `<`, `<=`, `>`, `>=` operators. Some comparisons involving `()` and float `NaN` are considered unordered. So if these unordered types are encountered in the query, they will be returned as the last elements of the ordered collection.

Syntax to write order by clause is `order by expression orderDirection`. Order direction can be `ascending` or `descending`.

::: code ordering.bal :::

::: out ordering.out :::

## Related links
- [Query expressions - Ballerina by example](https://ballerina.io/learn/by-example/query-expressions)
- [Let clause in query expression - Ballerina by example](https://ballerina.io/learn/by-example/let-clause)
- [Limit clause in query expression - Ballerina by example](https://ballerina.io/learn/by-example/limit-clause)
- [Joining iterable objects using query - Ballerina by example](https://ballerina.io/learn/by-example/joining-iterable-objects)
- [Querying tables - Ballerina by example](https://ballerina.io/learn/by-example/querying-tables)
- [Create maps with query expression - Ballerina by example](https://ballerina.io/learn/by-example/create-maps-with-query)
- [Create tables with query expression - Ballerina by example](https://ballerina.io/learn/by-example/create-tables-with-query)
- [Create streams with query expression - Ballerina by example](https://ballerina.io/learn/by-example/create-streams-with-query)
- [On conflict clause in query expression - Ballerina by example](https://ballerina.io/learn/by-example/on-conflict-clause)
- [Nested query expressions - Ballerina by example](https://ballerina.io/learn/by-example/nested-query-expressions)
