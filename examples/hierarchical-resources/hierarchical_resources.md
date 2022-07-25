# Hierarchical resources

Resource name is a relative path, which can have multiple path segments. Base path is an absolute path. A listener can have multiple services each with different base paths.

::: code hierarchical_resources.bal :::

Run the service using the `bal run` command.

::: out hierarchical_resources.server.out :::

Run this cURL command to invoke the resource.

::: out hierarchical_resources.client.out :::