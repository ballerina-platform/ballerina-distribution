# Connection-oriented client

The ConnectClient is configured so that it only receives data from,
and sends data to, the given remote peer address. Once connected,
data may not be received from or sent to any other address.
The client remains connected until it is explicitly disconnected or until it is closed.
This sample demonstrates how to send data to a connected server and print the echoed response.<br/><br/>
For more information on the underlying module, 
see the [UDP module](https://docs.central.ballerina.io/ballerina/udp/latest).

::: code udp_connect_client.bal :::

::: out udp_connect_client.out :::