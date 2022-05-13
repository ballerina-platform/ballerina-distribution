# Let clause

Query expressions can have `let` clauses. They can be anywhere between `from` and `select`
clauses. Multiple `where` clauses are also allowed. The semantics are similar to `XQuery FLWOR`.

::: code ./examples/let-clause/let_clause.bal :::

::: out ./examples/let-clause/let_clause.out :::