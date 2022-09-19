# Historical message replay

The `nats` streaming library provides the functionality of historical message replay. New subscriptions may specify a starting position in the stream of messages stored for the channel of the subscribed subject.

Message delivery may begin at:
1. The earliest message stored for this subject.
2. The most recently stored message for this subject prior to the start of the current subscription.
3. A historical offset from the current server date/time (e.g., the last 30 seconds).
4. A specific message sequence number.

For more information on the underlying module, see the [`stan` module](https://lib.ballerina.io/ballerinax/stan/latest).

::: code publisher.bal :::

::: out publisher.out :::

::: code subscriber.bal :::

When you start the subscriber after publishing several messages, You'll notice that,
1. `receiveSinceTimeDelta` service receives the messages if the messages were sent within a historical offset of 5 seconds from the current server date/time.
2. `receiveFromGivenIndex` service receives services messages starting from the third message published.
3. `receiveFromLastReceived` service receives messages starting from the last published message.
4. `receiveFromBeginning` service receives all messages ever published.
5. `receiveNewOnly` service receives only the messages, which are published after the subscriber starts.

::: out subscriber.out :::
