# Transaction statement

Ballerina provides support for interacting with a transaction manager.
Compile-time guarantees that transactions are bracketed with begin and `commit` or `rollback`.
The region in the middle is typed as being a transactional context.
Ballerina does not have a transactional memory and includes a transaction manager.
The current transaction is a part of the execution context of a strand.

::: code transaction_statement.bal :::

::: out transaction_statement.out :::