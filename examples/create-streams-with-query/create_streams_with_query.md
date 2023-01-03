# Create streams with query

Query expression can be used to create streams. The query expression should be preceded by the `stream` keyword in this case. If the expected stream type is `stream<T>` then the `select` clause must return values belonging to `T`.

When constructing stream from the query expression, clauses in the query expression are executed lazily which are called as a result of next operations being performed on the constructed stream. The failure of check within the query will cause the stream to produce an error termination value.

::: code creating_tables_with_query.bal :::

::: out creating_tables_with_query.out :::

## Related links
- [Query expressions - Ballerina by example](https://ballerina.io/learn/by-example/query-expressions)
- [Sort iterable objects using query - Ballerina by example](https://ballerina.io/learn/by-example/sort-iterable-objects)
- [Let clause in query expression - Ballerina by example](https://ballerina.io/learn/by-example/let-clause)
- [Limit clause in query expression - Ballerina by example](https://ballerina.io/learn/by-example/limit-clause)
- [Joining iterable objects using query - Ballerina by example](https://ballerina.io/learn/by-example/joining-iterable-objects)
- [Querying tables - Ballerina by example](https://ballerina.io/learn/by-example/querying-tables)
- [Create maps with query expression - Ballerina by example](https://ballerina.io/learn/by-example/create-maps-with-query)
- [Create tables with query expression - Ballerina by example](https://ballerina.io/learn/by-example/create-tables-with-query)
- [On conflict clause in query expression - Ballerina by example](https://ballerina.io/learn/by-example/on-conflict-clause)
- [Nested query expressions - Ballerina by example](https://ballerina.io/learn/by-example/nested-query-expressions)