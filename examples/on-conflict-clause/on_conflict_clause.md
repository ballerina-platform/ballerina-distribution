# The `on conflict` clause

When constructing a map or a table with a key sequence using a query expression, there can be conflicting keys. The `on conflict` clause can be specified after the `select` clause to handle these cases.

The syntax to write an `on conflict` clause is `on conflict expression`. The type of the expression should be `error?`. If the result of evaluating the expression is an error, then, the error will be the result. Otherwise, the old value is replaced by the new value.

::: code on_conflict_clause.bal :::

::: out on_conflict_clause.out :::

## Related links
- [Query expressions](/learn/by-example/query-expressions)
- [Sort iterable objects using query](/learn/by-example/sort-iterable-objects)
- [Let clause in query expression](/learn/by-example/let-clause)
- [Limit clause in query expression](/learn/by-example/limit-clause)
- [Joining iterable objects using query](/learn/by-example/joining-iterable-objects)
- [Querying tables](/learn/by-example/querying-tables)
- [Create maps with query expression](/learn/by-example/create-maps-with-query)
- [Create tables with query expression](/learn/by-example/create-tables-with-query)
- [Create streams with query expression](/learn/by-example/create-streams-with-query)
- [Nested query expressions](/learn/by-example/nested-query-expressions)
