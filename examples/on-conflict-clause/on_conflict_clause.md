# `on conflict` clause

When constructing a map or a table with a key sequence using a query expression, there can be conflicting keys. The `on conflict` clause can be specified after the `select` clause to handle these cases.

The `on conflict` clause uses the syntax `on conflict <expression>`, where the expression must be of type `error?`. If a conflicting key is found, and the expression evaluates to an error, that error becomes the result of the query expression. If it evaluates to `null` or the `on conflict` clause is absent, the old value is replaced by the new value.

::: code on_conflict_clause.bal :::

::: out on_conflict_clause.out :::

## Related links
- [Advanced conflict handling](/learn/by-example/advanced-conflict-handling)
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
