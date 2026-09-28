# Agent execution trace

Understanding how an agent arrived at an answer is essential for debugging, evaluation, and observability. When `ai:Trace` is used as the expected type of the `run` method, the agent returns the full execution trace instead of only the final answer. The trace (`ai:Trace`) captures the user message, each reasoning-action cycle (`ai:Iteration`) with the message history and the outputs produced (tool results, assistant messages, or errors), the tool calls requested by the LLM, the final output, the tool schemas, and the start and end times.

Traces are also the input to agent evaluations (see the [Agent evaluation](/learn/by-example/ai-agent-evaluation/) example). For production observability, the agent execution is recorded as OpenTelemetry spans and, when tracing is enabled, published to the configured tracing provider, such as Jaeger (see the [Publish agent traces to Jaeger](/learn/by-example/ai-agent-tracing-jaeger/) example) or the WSO2 AI Agent Management Platform with the [ballerinax/amp](https://central.ballerina.io/ballerinax/amp/latest) module.

This example demonstrates how to obtain and inspect the execution trace of an agent run.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_execution_trace.bal :::

::: out ai_agent_execution_trace.out :::

## Related links
- [The Agent evaluation example](/learn/by-example/ai-agent-evaluation/)
- [The Publish agent traces to Jaeger example](/learn/by-example/ai-agent-tracing-jaeger/)
- [The Agent with typed input and output example](/learn/by-example/ai-agent-typed-input-output/)
- [The `ballerinax/amp` module](https://central.ballerina.io/ballerinax/amp/latest)
- [Overview of Ballerina observability](/learn/overview-of-ballerina-observability/)
