# Query actions

A query action allows you to use the functionalities of a query expression to iteratively execute a code block like a `foreach` statement. A Query action starts with a `from` clause and ends with a `do` clause. It can contain all the intermediate clauses in a query expression.

The clauses in a query action are executed in the same way as the clauses in a query expression. If a clause completes early with an error `e`, the result of the query action is `e`. Otherwise, the result is `null`.

::: code query_actions.bal :::

::: out query_actions.out :::

## Related links
- [Query expressions - Ballerina by example](/learn/by-example/query-expressions)
