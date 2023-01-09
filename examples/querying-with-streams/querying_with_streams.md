# Querying with streams

A query expression can be used to call the `next()` method of a stream iteratively. A binding pattern in a query 
expression will bind the value of the result from the `next()` operation on the stream. If the stream terminates 
with an error, result of the query expression will be the error.

::: code querying_with_streams.bal :::

::: out querying_with_streams.out :::

## Related links
- [Query expressions - Ballerina by example](/learn/by-example/query-expressions)
- [Sort iterable objects using query - Ballerina by example](/learn/by-example/sort-iterable-objects)
- [Let clause in query expression - Ballerina by example](/learn/by-example/let-clause)
- [Limit clause in query expression - Ballerina by example](/learn/by-example/limit-clause)
- [Joining iterable objects using query - Ballerina by example](/learn/by-example/joining-iterable-objects)
- [Querying tables - Ballerina by example](/learn/by-example/querying-tables)
- [Create maps with query expression - Ballerina by example](/learn/by-example/create-maps-with-query)
- [Create tables with query expression - Ballerina by example](/learn/by-example/create-tables-with-query)
- [Create streams with query expression - Ballerina by example](/learn/by-example/create-streams-with-query)
- [On conflict clause in query expression - Ballerina by example](/learn/by-example/on-conflict-clause)
- [Nested query expressions - Ballerina by example](/learn/by-example/nested-query-expressions)
