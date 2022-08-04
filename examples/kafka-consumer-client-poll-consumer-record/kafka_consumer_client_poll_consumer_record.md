# Consumer client - Poll ConsumerRecord

This shows how to use a `kafka:Consumer` as a simple record
consumer. The records from a subscribed topic can be retrieved using the
`poll()` function.
This consumer uses the builtin byte array deserializer for both the key and
the value, which is the default deserializer in the `kafka:Consumer`.
The received records are converted to the user defined type using data-binding.
For this to work properly, an active Kafka broker should be present.
<br/><br/>
For more information on the underlying module, 
see the [Kafka module](https://lib.ballerina.io/ballerinax/kafka/latest).

::: code kafka_consumer_client_poll_consumer_record.bal :::

::: out kafka_consumer_client_poll_consumer_record.out :::