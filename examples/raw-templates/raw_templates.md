# Raw templates

A raw template is a backtick template without a tag. Exposes result of phase 1 without further processing. Raw template is evaluated by evaluating each expression and creating an object containing.

- an `array` of the `strings` separated by insertions
- an `array` of the results of expression evaluation and an `array` of `strings` separating

>**Important use case:** SQL parameters.

>**Note:** The relevant database driver JAR should be defined in the `Ballerina.toml` file as a dependency. This sample is based on an H2 database and the H2 database driver JAR need to be added to `Ballerina.toml` file. This sample is written using H2 2.1.210 and it is recommended to use H2 JAR with versions higher than 2.1.210.

For a sample configuration and more information on the underlying module, see the [JDBC module](https://lib.ballerina.io/ballerinax/java.jdbc/latest/).

::: code raw_templates.bal :::

Add the relevant database driver JAR details to the `Ballerina.toml` file.

::: code Ballerina.toml :::

Build and run the project using the `bal run` command.

::: out raw_templates.out :::