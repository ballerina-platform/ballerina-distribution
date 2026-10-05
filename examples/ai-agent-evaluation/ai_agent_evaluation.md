# Agent evaluation

An agent's behavior depends on the model, the system prompt, and the tools, and can regress when they change. The [`ballerina/ai.eval`](https://central.ballerina.io/ballerina/ai.eval/latest) module provides evaluation templates that run an agent and check the outcome in ordinary Ballerina tests. Rule-based templates, such as `assertIterationEfficiency` and `assertContentCoverage`, are scored in code without an LLM. LLM-as-a-judge templates, such as `evaluateHelpfulness`, use a judge model and pass when its score reaches the threshold.

This example evaluates a finance agent with both kinds of templates, written as test functions in the `tests` directory.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai.eval` module](https://lib.ballerina.io/ballerina/ai.eval/latest/).

::: code ai_agent_evaluation.bal :::

::: out ai_agent_evaluation.out :::

## Related links
- [The Agent execution trace example](/learn/by-example/ai-agent-execution-trace/)
- [Test Ballerina code](/learn/test-ballerina-code/write-tests/)
- [The `ballerina/ai.eval` module](https://central.ballerina.io/ballerina/ai.eval/latest)
