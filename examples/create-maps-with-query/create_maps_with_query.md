# Create maps with query

A query expressions can be used to create a map from an iterable value. A query expression should be preceded by the `map` keyword in this case.

The type of the value in the `select` clause must belong to the tuple type `[string, T]`, where the type of the constructed value is `map<T>`.

::: code create_maps_with_query.bal :::

::: out create_maps_with_query.out :::

## Related links
- [Query expressions](/learn/by-example/query-expressions)
- [Sort iterable objects using query](/learn/by-example/sort-iterable-objects)
- [Let clause in query expression](/learn/by-example/let-clause)
- [Limit clause in query expression](/learn/by-example/limit-clause)
- [Joining iterable objects using query](/learn/by-example/joining-iterable-objects)
- [Querying tables](/learn/by-example/querying-tables)
- [Create tables with query expression](/learn/by-example/create-tables-with-query)
- [Create streams with query expression](/learn/by-example/create-streams-with-query)
- [On conflict clause in query expression](/learn/by-example/on-conflict-clause)
- [Nested query expressions](/learn/by-example/nested-query-expressions)
