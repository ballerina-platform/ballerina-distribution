# Query actions

The clauses in a query action are executed in the same way as the clauses in a query expression.

Query action starts with the `from` clause and ends with the `do` clause.
In the same way, the query is built in query expressions, query actions also can have intermediate clauses of  `let`, `join`, `order by`, `where`, and `limit` clauses.

If a clause in the query action completes early with an error `e`, the result of the query action is `e`. Otherwise, the result of the query action is `nil`.

::: code query_actions.bal :::

::: out query_actions.out :::