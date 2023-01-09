# Sort iterable objects

The `order by` clause in the query expression can be used to sort the elements in a collection. Ordering works 
consistently with the `<`, `<=`, `>`, `>=` operators. Some comparisons involving `()` and float `NaN` are considered 
unordered. Therefore, if these unordered types are encountered in the query, they will be returned as the last elements 
of the ordered collection.

The syntax to write an `order by` clause is `order by expression orderDirection`. The order direction can be 
`ascending` or `descending`.

::: code sort_iterable_objects.bal :::

::: out sort_iterable_objects.out :::

## Related links
- [Query expressions - Ballerina by example](/learn/by-example/query-expressions)
- [Let clause in query expression - Ballerina by example](/learn/by-example/let-clause)
- [Limit clause in query expression - Ballerina by example](/learn/by-example/limit-clause)
- [Joining iterable objects using query - Ballerina by example](/learn/by-example/joining-iterable-objects)
- [Querying tables - Ballerina by example](/learn/by-example/querying-tables)
- [Create maps with query expression - Ballerina by example](/learn/by-example/create-maps-with-query)
- [Create tables with query expression - Ballerina by example](/learn/by-example/create-tables-with-query)
- [Create streams with query expression - Ballerina by example](/learn/by-example/create-streams-with-query)
- [On conflict clause in query expression - Ballerina by example](/learn/by-example/on-conflict-clause)
- [Nested query expressions - Ballerina by example](/learn/by-example/nested-query-expressions)
