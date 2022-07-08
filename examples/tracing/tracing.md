# Distributed tracing

Ballerina supports Observability out of the box, and Tracing is one of the three important aspects of
Observability. To observe Ballerina code, the build time flag `--observability-included` should be given along with the
`Config.toml` file when starting the service. The `Config.toml` file contains the required runtime configurations related to observability.
The developers can trace their code blocks and measure the time incurred during the actual runtime execution.
They can choose to hook their measurement with the default trace created or can create a completely new trace.<br/><br/>
For more information about configs and observing applications, see [Observing Ballerina Code](https://ballerina.io/learn/observing-ballerina-code/).

::: code tracing.bal :::

::: out tracing.client.out :::

::: out tracing.server.out :::