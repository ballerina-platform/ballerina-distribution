# Retry transaction statement

Transactional errors are often transient: retrying will fix them.
This works by creating a `RetryManager` object `r` before executing the transaction.
If the block fails with an error `e`, it calls `r.shouldRetry(e)`. If that returns `true`, then it executes the block again.
`retry` statement accepts an optional type parameter which is a class of `RetryManager` and optional arguments for the class's init method.
`DefaultRetryManager` tries 3 times.
`retry` can be used without `transaction`.

::: code retry_transaction_statement.bal :::

::: out retry_transaction_statement.out :::