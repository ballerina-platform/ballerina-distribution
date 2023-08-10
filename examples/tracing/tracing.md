# Distributed tracing

Ballerina supports Observability out of the box, and Tracing is one of the three important aspects of observability. To observe Ballerina code, the `--observability-included` build time flag should be given along with the `Config.toml` file when starting the service. The `Config.toml` file contains the required runtime configurations related to observability.

You can trace the code blocks and measure the time incurred during the actual runtime execution. Also, you can choose to hook the measurement with the default trace created or can create a completely new trace.

>**Info:** For more information about configs and observing applications, see [Observe Ballerina programs](/learn/observe-ballerina-programs/).

::: code tracing.bal :::

Invoke the service using cURL and access [Jaeger UI](http://localhost:16686).

::: out tracing.client.out :::

Jaeger is the default tracing tool used in Ballerina. To start the Jaeger, execute the command below.

To start the service, navigate to the directory that contains the
`.bal` file, and execute the `bal run` command below with the `--observability-included` build time flag and the `Config.toml` runtime configuration file.

::: out tracing.server.out :::
