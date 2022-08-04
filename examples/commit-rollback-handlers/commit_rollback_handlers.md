# Commit/rollback handlers

Often code needs to get executed depending on whether a transaction is committed.
Testing the result of the `commit` within the transaction statement works. However, it is inconvenient
from a modularity perspective, particularly, when you want to undo changes on `rollback`.
This seems much worse in a distributed transaction when the transaction statement is in another program.
Ballerina provides `commit`/`rollback` handlers, which are functions that get executed when the decision
whether to commit is known.

::: code commit_rollback_handlers.bal :::

::: out commit_rollback_handlers.out :::