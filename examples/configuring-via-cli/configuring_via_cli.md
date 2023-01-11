# Configuring via command line arguments

The values of the configurable variables can be configured through the command line arguments when executing the Ballerina program. The provided value is expected to be the `toString()` representation of the intended value.

The command-line-based configuration is only supported for configurable variables of types `int`, `byte`, `float`, `boolean`, `string`, `decimal`, `enum`, and `xml`.
The syntax `-Ckey=value` can be used to provide values through the command line parameters.

For more information, see [Configure via command line arguments](/learn/configure-ballerina-programs/provide-values-to-configurable-variables/#provide-via-command-line-arguments/).

::: code configuring_via_cli.bal :::

::: out configuring_via_cli.out :::
