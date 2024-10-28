# Join iterable objects

A `join` clause performs an inner or left outer equi-join. The result is similar to using the nested `from` clauses and a `where` clause. Variables declared in the query expression before the join clause are accessible only on the left side of the join condition, while variables declared in the join clause are accessible only on the right side of the join condition.

::: code joining_iterable_objects.bal :::

::: out joining_iterable_objects.out :::

## Related links
- [Query expressions](/learn/by-example/query-expressions)
- [Sort iterable objects using query](/learn/by-example/sort-iterable-objects)
- [Let clause in query expression](/learn/by-example/let-clause)
- [Limit clause in query expression](/learn/by-example/limit-clause)
- [Querying tables](/learn/by-example/querying-tables)
- [Create maps with query expression](/learn/by-example/create-maps-with-query)
- [Create tables with query expression](/learn/by-example/create-tables-with-query)
- [Create streams with query expression](/learn/by-example/create-streams-with-query)
- [On conflict clause in query expression](/learn/by-example/on-conflict-clause)
- [Nested query expressions](/learn/by-example/nested-query-expressions)
