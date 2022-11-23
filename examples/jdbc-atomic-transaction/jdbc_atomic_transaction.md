# JDBC client - Atomic transactions

This BBE demonstrates how to use the JDBC client to execute a batch of DDL/DML operations with the help of a `transaction` to achieve the atomic behaviour.

>**Note:** This sample is based on an H2 database and the H2 database driver JAR needs to be added to the `Ballerina.toml` file. This sample is written using H2 2.0.6 and it is recommended to use an H2 JAR file of a version higher than 2.0.2. For a sample configuration, see the [`jdbc` module](https://lib.ballerina.io/ballerinax/java.jdbc/latest/).

::: code jdbc_atomic_transaction.bal :::

Create a Ballerina project. Copy the example to the project and add the relevant database driver JAR details to the `Ballerina.toml` file. Execute the command below to build and run the project.

::: out jdbc_atomic_transaction.out :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::

## Related links
- [`jdbc:Client` - API documentation](https://lib.ballerina.io/ballerinax/java.jdbc/latest/)
- [`jdbc:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-java.jdbc/blob/master/docs/spec/spec.md#2-client)
