# Join clause

A query expression can take advantage of keys of a table by using a `join` clause. It performs an inner equijoin. The result is similar to using nested `from` clauses and `where` clause. It is implemented as a hash join. Table keys allow you to avoid building a hash table. The type to join must be `anydata`.

::: code join_clause.bal :::

::: out join_clause.out :::