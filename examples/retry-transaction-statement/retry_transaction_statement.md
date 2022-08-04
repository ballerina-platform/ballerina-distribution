# Retry transaction statement

Transactional errors are often transient: retrying will fix them.
This works by creating a  RetryManager object `r`, before executing the transaction.
If the block fails with error `e`, it calls `r.shouldRetry(e)`.
If that returns `true`, then it executes the block again.
`retry` has an optional type parameter giving class of `RetryManager` to create, and optional arguments to new `DefaultRetryManager` tries `n` times.
`retry` can be used without `transaction`.

::: code retry_transaction_statement.bal :::

::: out retry_transaction_statement.out :::