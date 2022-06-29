# Raw templates

A raw template is a backtick template without a tag. It exposes the result of phase 1 without further processing. It is evaluated by evaluating each expression and creating an object containing,
- an array of the strings separated by insertions
- an array of the results of expression evaluation and an array of strings separating

Using raw templates in SQL parameters is an important use case.
Note that the relevant database driver JAR should be defined in the `Ballerina.toml` file as a dependency. This sample is based on an H2 database and the H2 database driver JAR need to be added to `Ballerina.toml` file. For a sample configuration and more information on the underlying module, see the [JDBC module](https://docs.central.ballerina.io/ballerinax/java.jdbc/latest/). This sample is written using H2 2.1.210 and it is recommended to use H2 JAR with versions higher than 2.1.210.

Create a Ballerina project and copy the following example to the project.

::: code raw_templates.bal :::

Add relevant database driver jar details to the `Ballerina.toml` file.

::: code Ballerina.toml :::

Build and run the project using the `bal run` command.

::: out raw_templates.out :::