# Transactional named workers

A named worker within a transactional function can be declared as `transactional`.
This will start a new transaction branch for the named worker, as with a distributed transaction.

::: code ./examples/transactional-named-workers/transactional_named_workers.bal :::

::: out ./examples/transactional-named-workers/transactional_named_workers.out :::