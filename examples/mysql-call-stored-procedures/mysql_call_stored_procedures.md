# Call stored procedures

This BBE demonstrates how to use the MySQL client to execute a stored
procedure. 

Note that the MySQL database driver JAR should be defined in the `Ballerina.toml` file as a dependency.

For a sample configuration and more information on the underlying module, see the [`mysql` module](https://docs.central.ballerina.io/ballerinax/mysql/latest/).
The MySQL connector uses database properties from MySQL version 8.0.13 onwards. Therefore, it is
recommended to use a MySQL driver version greater than 8.0.13.

::: code mysql_call_stored_procedures.bal :::

::: out mysql_call_stored_procedures.out :::

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: cleanup.bal
