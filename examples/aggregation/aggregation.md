# Aggregation

The `group by` clause in the query expression can group the elements in a collection. Grouping happens based on the grouping keys provided in `group by` clause. For each group, grouping keys are unique. All other variables other than grouping keys are called non-grouping keys. For each group, non-grouping keys become sequence variables. Those variables can be used as a list or an argument to a rest parameter of a langlib function.

The `collect` clause collects the collection into one group. All the variables become aggregated variables and those variables can be used as a list or an argument to a rest parameter of a langlib function same as in `group by`.

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
