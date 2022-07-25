# Raw templates

A raw template is a backtick template without a tag. It exposes the result of phase 1 without further processing. It is evaluated by evaluating each expression and creating an object containing:
- an array of the strings separated by insertions
- an array of the results of the expression evaluation and an array of strings separating them

Using raw templates in SQL parameters is an important use case.
>**Note:**  The relevant database driver JAR should be defined in the `Ballerina.toml` file as a dependency. This sample is based on an H2 database and the H2 database driver JAR needs to be added to the `Ballerina.toml` file. For a sample configuration and more information on the underlying module, see the [`jdbc` module](https://docs.central.ballerina.io/ballerinax/java.jdbc/latest/). This sample is written using H2 2.1.210 and it is recommended to use an H2 JAR with versions higher than 2.1.210.

Create a Ballerina project and copy the following example to the project.

::: code raw_templates.bal :::

Add the relevant database driver JAR details to the `Ballerina.toml` file.

::: code Ballerina.toml :::

Build and run the project using the `bal run` command.

::: out raw_templates.out :::