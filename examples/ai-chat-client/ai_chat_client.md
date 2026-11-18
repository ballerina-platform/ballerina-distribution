# Chat client

Chat agents exposed via an `ai:Listener` accept chat messages over HTTP. The `ai:ChatClient` client provides a typed client for such chat services, so that other Ballerina programs (e.g., a web backend, a messaging integration, or a test) can interact with a chat agent without constructing HTTP requests manually.

The client sends `ai:ChatReqMessage` values, which carry a session ID and the message, and receives `ai:ChatRespMessage` values with the agent's reply. Messages sent with the same session ID share the conversation history maintained by the agent. For agents that pause for human approval, the client's `decision` resource can be used to submit the human's decisions to a chat service that defines a `decision` resource (see the [Human-in-the-loop agents](/learn/human-in-the-loop-agents/) guide).

This example demonstrates how to send messages to a chat agent service and continue a conversation within a session.

> Note: Start the chat agent service from the [Chat agents](/learn/by-example/chat-agents/) example before running this example.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_chat_client.bal :::

::: out ai_chat_client.out :::

## Related links
- [The Chat agents example](/learn/by-example/chat-agents/)
- [The Agent with in-memory short-term memory example](/learn/by-example/ai-agent-memory/)
