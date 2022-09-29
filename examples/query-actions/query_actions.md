# Query Actions

The clauses in a query-action are executed in the same way as the clauses in a query-expr.

In the same way the query is built in query expressions, the query can be built using other clauses such as `let` clause, `join` clause, `order by` clause, `where clause` and `limit` clause except the `select` clause.

If a clause in the query action completes early with error `e`, the result of the query-action is `e`. Otherwise, the result of the query-action is `nil`.

::: code query_actions.bal :::

::: out query_actions.out :::