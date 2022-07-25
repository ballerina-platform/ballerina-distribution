# Inter-worker failure propagation

Workers may need to call functions that can return an `error`. Pairing up of sends and receives guarantees that each send will be received and vice-versa provided that the worker has failed on both sending and receiving. Sending or receiving of the failed worker will propagate the failure.

::: code inter_worker_failure_propagation.bal :::

::: out inter_worker_failure_propagation.out :::