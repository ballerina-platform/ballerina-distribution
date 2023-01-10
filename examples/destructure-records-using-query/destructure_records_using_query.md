# Destructure records using queries

Destructuring records is particularly useful with the query expressions. But works anywhere you can have `var`. `var` is followed by a binding pattern. You can also specify the type explicitly before the binding pattern without using `var`.

`{x}` is short for `{x: x}` in both binding patterns and record constructors.

::: code destructure_records_using_query.bal :::

::: out destructure_records_using_query.out :::

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
- [On conflict clause in query expression](/learn/by-example/on-conflict-clause)
- [Nested query expressions](/learn/by-example/nested-query-expressions)
