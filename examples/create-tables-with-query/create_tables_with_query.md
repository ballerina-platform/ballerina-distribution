# Create tables with a query

A query expressions can be used to create tables from an iterable value. One way of doing this is specifying `table` keyword as the query construct type before the query expression. The key of the created table can  be specified explicitly. Second way is to provide a contextually expected type. The `select` clause must emit values belonging to `map<any|error>`.

::: code create_tables_with_query.bal :::

::: out create_tables_with_query.out :::

## Related links
- [Query expressions](/learn/by-example/query-expressions)
- [Sort iterable objects using query](/learn/by-example/sort-iterable-objects)
- [Let clause in query expression](/learn/by-example/let-clause)
- [Limit clause in query expression](/learn/by-example/limit-clause)
- [Joining iterable objects using query](/learn/by-example/joining-iterable-objects)
- [Querying tables](/learn/by-example/querying-tables)
- [Create maps with query expression](/learn/by-example/create-maps-with-query)
- [Create streams with query expression](/learn/by-example/create-streams-with-query)
- [On conflict clause in query expression](/learn/by-example/on-conflict-clause)
- [Nested query expressions](/learn/by-example/nested-query-expressions)
