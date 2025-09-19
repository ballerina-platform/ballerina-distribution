# Configure via TOML files

The values of the configurable variables can be configured through the configuration files in the TOML(v0.4) format.

The file location can be specified through an environment variable with the name `BAL_CONFIG_FILES`. Specifying multiple configuration files is supported using this environment variable with the OS-specific separator. If an environment variable is not specified, a file named `Config.toml` will be sought in the current working directory.

An environment variable with the name `BAL_CONFIG_DATA` can be used to provide the configuration file content instead of a separate file.

For more information, see [Configure via TOML syntax](/learn/provide-values-to-configurable-variables/#provide-via-toml-syntax/).

::: code configuring_via_toml.bal :::

To run the example, copy the following content to a file named `Config.toml` in the current directory.

::: code Config.toml :::

::: out configuring_via_toml.out :::
