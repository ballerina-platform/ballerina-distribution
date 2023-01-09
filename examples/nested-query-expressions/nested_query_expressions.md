# Nested query expressions

Intermediate clauses of a query expression can contain another query expression and there is no limit to the amount of such nested query expressions. This is similar to nested `foreach` statements. Nested query expressions are useful to create complex query expressions. Execution will happen according to the respective clauses.

::: code nested_query_expressions.bal :::

::: out nested_query_expressions.out :::

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
