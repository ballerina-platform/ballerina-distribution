# Agent ID

An agent that calls external services needs its own identity, so its access can be controlled and audited separately. Set the `credential` field of the agent to an `ai:Credential` with its ID and secret from the authorization server. A tool declares its required authorization in the `auth` field of `@ai:AgentTool`. Before calling the tool, the agent gets an access token for the required scopes and passes it to the tool.

This example gives a scheduling agent an identity and a calendar tool that uses its token.

> Note: This example requires an agent identity registered with an authorization server, and an OAuth 2.0 client for the application. Add the agent ID and secret, the authorization server URL, the client credentials, and the redirect URI to the `Config.toml` file. It also uses the default model provider implementation; run the `Configure default WSO2 Model Provider` command from the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`) to add that configuration.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_id.bal :::

## Related links
- [The Passing context to agent tools example](/learn/by-example/ai-agent-tool-context/)
- [The Agent with human-in-the-loop example](/learn/by-example/ai-agent-human-in-the-loop/)
- [The Agent with external endpoint integration example](/learn/by-example/ai-agent-external-endpoint-integration/)
