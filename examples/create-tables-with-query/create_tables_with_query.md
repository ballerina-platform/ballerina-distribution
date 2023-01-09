# Create tables with query

Query expressions can be used to create tables from an iterable value. One way of doing this is specifying
`table` keyword as the query construct type before the query expression. The key of the created table can 
be specified explicitly. Second way is to provide a contextually expected type. 
The `select` clause must emit values belonging to `map<any|error>`.

::: code creating_tables_with_query.bal :::

::: out creating_tables_with_query.out :::

## Related links
- [Query expressions - Ballerina by example](/learn/by-example/query-expressions)
- [Sort iterable objects using query - Ballerina by example](/learn/by-example/sort-iterable-objects)
- [Let clause in query expression - Ballerina by example](/learn/by-example/let-clause)
- [Limit clause in query expression - Ballerina by example](/learn/by-example/limit-clause)
- [Joining iterable objects using query - Ballerina by example](/learn/by-example/joining-iterable-objects)
- [Querying tables - Ballerina by example](/learn/by-example/querying-tables)
- [Create maps with query expression - Ballerina by example](/learn/by-example/create-maps-with-query)
- [Create streams with query expression - Ballerina by example](/learn/by-example/create-streams-with-query)
- [On conflict clause in query expression - Ballerina by example](/learn/by-example/on-conflict-clause)
- [Nested query expressions - Ballerina by example](/learn/by-example/nested-query-expressions)
