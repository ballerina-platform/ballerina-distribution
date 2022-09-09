# Counter-based metrics

Ballerina supports Observability out of the box and Metrics is one of the three important aspects of  Observability.To observe Ballerina code, the `--observability-included` build time flag should be given along with the `Config.toml` file when starting the service. The `Config.toml` file contains the required runtime configurations related to observability.

You can define and use metrics to measure your own logic. A counter is one type of the metrics that is supported by default in Ballerina, and it is a cumulative metric that represents a single monotonically-increasing counter whose value can only increase or be reset to zero.

For more information about configs and observing applications, see [Observe Ballerina programs](/learn/observe-ballerina-programs/).

::: code counter_metrics.bal :::

Invoke the service using the cURL command below.

::: out counter_metrics.client.out :::

To start the service, navigate to the directory that contains the
`.bal` file, and execute the `bal run` command below with the `--observability-included` build time flag and the `Config.toml` runtime configuration file.

::: out counter_metrics.server.out :::
