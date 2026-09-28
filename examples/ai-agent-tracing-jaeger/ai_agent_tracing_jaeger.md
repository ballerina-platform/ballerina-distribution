# Publish agent traces to Jaeger

The `ballerina/ai` module records the execution of an agent as OpenTelemetry spans that follow the OpenTelemetry semantic conventions for generative AI. The creation of an agent is recorded as a `create_agent` span, and each run as an `invoke_agent` span with a `chat` span for each LLM call and an `execute_tool` span for each tool call as its children. The spans carry `gen_ai.*` attributes, such as the agent name, the model, the token usage, and the tool arguments and results. When tracing is enabled, the spans are published to the configured trace provider, such as [Jaeger](https://www.jaegertracing.io/), together with the spans of the HTTP requests that the agent serves and makes.

To publish the traces to Jaeger, import the `ballerinax/jaeger` module, build the program with observability included, and enable tracing with the `jaeger` provider in the `Config.toml` file. No tracing code is needed in the program.

This example demonstrates how to publish the traces of an agent exposed as a chat service to Jaeger.

> Note: Start Jaeger before running this example. For example, run it with Docker as follows, which exposes the OpenTelemetry (OTLP) gRPC endpoint on port `4317` and the Jaeger UI on port `16686`.
>
> `docker run -d -p 16686:16686 -p 4317:4317 jaegertracing/jaeger:latest`

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_tracing_jaeger.bal :::

Add the following configuration to the `Config.toml` file. The `[ballerinax.jaeger]` section sets the host and the port of the OTLP gRPC endpoint of Jaeger.

::: code Config.toml :::

Run the service with the `--observability-included` build option. In a Ballerina package, set `observabilityIncluded = true` under `[build-options]` in the `Ballerina.toml` file instead.

::: out ai_agent_tracing_jaeger.server.out :::

Invoke the service by executing the cURL command below.

::: out ai_agent_tracing_jaeger.client.out :::

Open the Jaeger UI at [http://localhost:16686](http://localhost:16686) and select the `/inventory` service to view the trace. The `invoke_agent Inventory Assistant` span contains a `chat gpt-4o-mini` span for each LLM call, and the `execute_tool getStockLevel` and `execute_tool getUnitsOnOrder` spans for the tool calls.

## Related links
- [The Agent execution trace example](/learn/by-example/ai-agent-execution-trace/)
- [The Agent evaluation example](/learn/by-example/ai-agent-evaluation/)
- [The Distributed tracing example](/learn/by-example/tracing/)
- [Observe tracing using Jaeger](/learn/supported-observability-tools-and-platforms/jaeger/)
- [WSO2 Integration Platform: Observability](https://wso2.com/integration-platform/docs/genai/develop/agents/observability)
