# Inter-worker failure propagation

Workers may need to call functions that can return an `error`. Pairing up of sends and receives guarantees that each send will be received, and vice-versa, provided neither sending nor receiving worker has failed. Send to or receive from failed worker will propagate the failure.

::: code inter_worker_failure_propagation.bal :::

::: out inter_worker_failure_propagation.out :::