# Publish agent traces to Jaeger

An AI agent records each run as a trace, with a step for the run itself, each LLM call, and each tool call. You can send these traces to a tracing tool such as [Jaeger](https://www.jaegertracing.io/) and see step by step what the agent did. You do not need to write any tracing code. Import `ballerinax/jaeger` and turn tracing on in the `Config.toml` file.

This example sends the traces of an agent chat service to Jaeger.

> Note:<br />• Start Jaeger before running this example, for example with Docker: `docker run -d -p 16686:16686 -p 4317:4317 jaegertracing/jaeger:latest`<br />• This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_tracing_jaeger.bal :::

Add the following configuration to the `Config.toml` file. It turns tracing on and points it to Jaeger.

::: code Config.toml :::

Run the service with the `--observability-included` option. In a Ballerina package, set `observabilityIncluded = true` under `[build-options]` in the `Ballerina.toml` file instead.

::: out ai_agent_tracing_jaeger.server.out :::

Invoke the service by executing the cURL command below.

::: out ai_agent_tracing_jaeger.client.out :::

Open the Jaeger UI at [http://localhost:16686](http://localhost:16686) and select the `/inventory` service. The trace shows the agent run, each LLM call, and the calls to the `getStockLevel` and `getUnitsOnOrder` tools.

## Related links
- [The Agent execution trace example](/learn/by-example/ai-agent-execution-trace/)
- [The Agent evaluation example](/learn/by-example/ai-agent-evaluation/)
- [The Distributed tracing example](/learn/by-example/tracing/)
- [Observe tracing using Jaeger](/learn/supported-observability-tools-and-platforms/jaeger/)
- [WSO2 Integration Platform: Observability](https://wso2.com/integration-platform/docs/genai/develop/agents/observability)
