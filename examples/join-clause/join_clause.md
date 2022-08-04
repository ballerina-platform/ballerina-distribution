# Join clause

`Query` can take advantage of `table` keys by using a `join clause`. Performs an `inner equijoin`.
The result is similar to using nested `from clause` and `where clause`. It is implemented as
a hash join: `table` keys allow you to avoid building a hash table. The type to join on must be `anydata`.

::: code join_clause.bal :::

::: out join_clause.out :::