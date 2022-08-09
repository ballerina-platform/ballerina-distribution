# Transactional named workers

A named worker within a transactional function can be declared as `transactional`.
This will start a new transaction branch for the named worker, as with a distributed transaction.

::: code transactional_named_workers.bal :::

::: out transactional_named_workers.out :::