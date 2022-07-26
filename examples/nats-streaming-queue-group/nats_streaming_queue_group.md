# Queue groups

The `nats` streaming library provides the built-in load balancing
feature called "distributed queues". All subscribers with the
same queue name form the queue group.  As messages on the registered
subject are published, one member of the group is chosen randomly
to receive the message. Although queue groups have multiple subscribers,
each message is consumed by only one.

For more information on the underlying module, 
see the [STAN module](https://lib.ballerina.io/ballerinax/stan/latest).

::: code publisher.bal :::

::: out publisher.out :::

::: code queue-group.bal :::

`queue-group.bal` contains three services belonging to the same queue group.
When several messages are published, it can be noticed that 
each message is received by only one queue group member.

::: out queue-group.out :::
