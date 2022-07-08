# Gauge-based metrics

Ballerina supports Observability out of the box and Metrics is one of the three important aspects of the
Observability. To observe Ballerina code, the build time flag `--observability-included` should be given along with the
`Config.toml` file when starting the service. The `Config.toml` file contains the required runtime configurations related to observability.
The developers can define and use metrics to measure their own logic. A gauge is one type of the metrics that is
supported by default in Ballerina, and it represents a single numerical value that can arbitrarily go up and down,
and also based on the statistics configurations provided to the Gauge, it can also report the statistics such as max,
min, mean, percentiles, etc.<br/><br/>
For more information about configs and observing applications, see [Observing Ballerina Code](https://ballerina.io/learn/observing-ballerina-code/).

::: code gauge_metrics.bal :::

::: out gauge_metrics.client.out :::

::: out gauge_metrics.server.out :::