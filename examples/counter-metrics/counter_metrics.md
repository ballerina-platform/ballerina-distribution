# Counter-based metrics

Ballerina supports Observability out of the box and Metrics is one of the three important aspects of 
Observability. To observe Ballerina code, the `--observability-included` build time flag should be given along with the
`Config.toml` file when starting the service. The `Config.toml` file contains the required runtime configurations related to observability.
You can define and use metrics to measure your own logic. A counter is one type of the metrics that is
supported by default in Ballerina, and it is a cumulative metric that represents a single monotonically-increasing
counter whose value can only increase or be reset to zero.<br/><br/>
For more information about configs and observing applications, see [Observing Ballerina Code](https://ballerina.io/learn/observing-ballerina-code/).

::: code counter_metrics.bal :::

::: out counter_metrics.client.out :::

::: out counter_metrics.server.out :::