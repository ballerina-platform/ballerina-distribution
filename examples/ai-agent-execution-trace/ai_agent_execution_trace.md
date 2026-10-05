# Agent execution trace

To see how an agent reached its answer, use `ai:Trace` as the expected type of `run` to get the full execution trace. The trace holds the user message, each reasoning-action cycle (`ai:Iteration`), the tool calls, the final output, and the start and end times. Traces are the input to [agent evaluations](/learn/by-example/ai-agent-evaluation/). With tracing enabled, runs are also published as OpenTelemetry spans to a provider such as [Jaeger](/learn/by-example/ai-agent-tracing-jaeger/) or the WSO2 AI Agent Management Platform ([ballerinax/amp](https://central.ballerina.io/ballerinax/amp/latest)).

This example gets the trace of an agent run and prints its contents.

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
