# Aggregation

The `group by` clause in the query expression can be used to group the elements in a collection. Grouping happens based on the grouping keys provided in `group by` clause. Non grouping keys becomes aggregated variables that can be used as a list or an argument to a rest parameter of a langlib function.

The `collect` clause is used to collect the collection into one group. All the variables becoes aggregated variables and those variables can be used as a list or an argument to a rest parameter of a langlib function same as in `group by`.

::: code aggregation.bal :::

::: out aggregation.out :::

## Related links
- [Query expressions](/learn/by-example/query-expressions)
- [Let clause in query expression](/learn/by-example/let-clause)
- [Limit clause in query expression](/learn/by-example/limit-clause)
- [Joining iterable objects using query](/learn/by-example/joining-iterable-objects)
- [Querying tables](/learn/by-example/querying-tables)
- [Create maps with query expression](/learn/by-example/create-maps-with-query)
- [Create tables with query expression](/learn/by-example/create-tables-with-query)
- [Create streams with query expression](/learn/by-example/create-streams-with-query)
- [On conflict clause in query expression](/learn/by-example/on-conflict-clause)
- [Nested query expressions](/learn/by-example/nested-query-expressions)
