# On conflict clause

When constructing a map or table with a key sequence using query expression,  there can be conflicting keys. on conflict clause can be specified after the select clause to handle these cases.

Syntax to write on conflict clause is `on conflict expression`. Type of the expression should be `error?`. If the result of evaluating the expression is an error, then the error will be the result. Otherwise, the old value is replaced by the new value.

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
- [Create streams with query expression - Ballerina by example](https://ballerina.io/learn/by-example/create-streams-with-query)
- [Nested query expressions - Ballerina by example](https://ballerina.io/learn/by-example/nested-query-expressions)
