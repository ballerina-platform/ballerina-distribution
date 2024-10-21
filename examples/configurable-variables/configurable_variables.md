# Configurable variables

A module-level variable can be declared as configurable. The initializer of a configurable variable can be overridden at runtime (e.g., by a TOML file). A variable for which a configuration is required can use an initializer of `?`. The type of a configurable variable must be a subtype of `anydata`.

For more information, see [Configure a sample Ballerina service](/learn/configure-a-sample-ballerina-service/).

::: code configurable_variables.bal :::

::: out configurable_variables.out :::
