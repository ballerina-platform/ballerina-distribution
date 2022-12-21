# Query actions

Query action allows us to use the functionalities of query expression to iteratively execute a code block like foreach statement. Query action starts with the from clause and ends with the do clause. It can contain all the intermediate clauses in query expression.

The clauses in a query action are executed in the same way as the clauses in a query expression. If a clause completes early with an error `e`, the result of the query action is `e`. Otherwise, the result is `null`.

::: code query_actions.bal :::

::: out query_actions.out :::

## Related links
- [Query expressions - Ballerina by example](https://ballerina.io/learn/by-example/query-expressions)
