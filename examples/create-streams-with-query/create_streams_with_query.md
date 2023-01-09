# Create streams with a query

A query expression can be used to create streams. The query expression should be preceded by the `stream` keyword in 
this case. If the expected stream type is `stream<T>`, then, the `select` clause must return values belonging to `T`.

When constructing a stream from a query expression, clauses in the query expression are executed lazily that are 
called as a result of the next operations being performed on the constructed stream. The failure of the `check` 
within the query will cause the stream to produce an error termination value.

::: code create_streams_with_query.bal :::

::: out create_streams_with_query.out :::

## Related links
- [Query expressions - Ballerina by example](/learn/by-example/query-expressions)
- [Sort iterable objects using query - Ballerina by example](/learn/by-example/sort-iterable-objects)
- [Let clause in query expression - Ballerina by example](/learn/by-example/let-clause)
- [Limit clause in query expression - Ballerina by example](/learn/by-example/limit-clause)
- [Joining iterable objects using query - Ballerina by example](/learn/by-example/joining-iterable-objects)
- [Querying tables - Ballerina by example](/learn/by-example/querying-tables)
- [Create maps with query expression - Ballerina by example](/learn/by-example/create-maps-with-query)
- [Create tables with query expression - Ballerina by example](/learn/by-example/create-tables-with-query)
- [On conflict clause in query expression - Ballerina by example](/learn/by-example/on-conflict-clause)
- [Nested query expressions - Ballerina by example](/learn/by-example/nested-query-expressions)