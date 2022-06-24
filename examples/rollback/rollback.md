# Rollback

If there is a fail or panic in the execution of the block, then the transaction is rolled back.
Transaction statement can also contain a rollback statement.
Every possible exit from a transaction block must be either `commit`, `rollback`, fail exit (e.g., from `check`), or panic exit.
Rollback does not automatically restore Ballerina variables to values before the transaction.

::: code rollback.bal :::

::: out rollback.out :::