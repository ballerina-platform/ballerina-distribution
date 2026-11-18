# Agent with typed input and output

The `run` method of an `ai:Agent` accepts any `anydata` value, such as a record, or a prompt template. Its result type is the expected type at the call site. For a record, the JSON schema of the type is sent to the LLM, and the response is validated and converted to that type. For `string`, you get the raw answer, and for `ai:Trace`, the full execution trace.

This example passes a request record to a trip planner agent and gets a typed itinerary, and then a string summary.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_typed_input_output.bal :::

::: out ai_agent_typed_input_output.out :::

## Related links
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [The Agent execution trace example](/learn/by-example/ai-agent-execution-trace/)
- [The Direct LLM calls example](/learn/by-example/direct-llm-calls/)
