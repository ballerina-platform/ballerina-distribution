# Gauge-based metrics

Ballerina supports observability out of the box and metrics is one of the three key components of observability. To observe Ballerina code, the build time flag `--observability-included` should be given along with the `Config.toml` file when starting the service. The `Config.toml` file should contain the required runtime configurations related to observability.

The developers can define and use metrics to measure their own logic. A gauge is one type of the metrics that is supported by default in Ballerina, and it represents a single numerical value that can arbitrarily go up and down, and also based on the statistics configurations provided to the Gauge, it can also report the statistics such as max, min, mean, percentiles, etc.

For more information about configs and observing applications, see [Observe Ballerina programs](/learn/observe-ballerina-programs/).

::: code gauge_metrics.bal :::

Invoke the service using the cURL command below.

::: out gauge_metrics.client.out :::

To start the service, navigate to the directory that contains the
`.bal` file, and execute the `bal run` command below with the `--observability-included` build time flag and the `Config.toml` runtime configuration file.

::: out gauge_metrics.server.out :::
