# Call stored procedures

This BBE demonstrates how to use the MySQL client to execute a stored procedure. 

For more information on the underlying module, see the [`mysql` module](https://lib.ballerina.io/ballerinax/mysql/latest/).

::: code mysql_call_stored_procedures.bal :::

::: out mysql_call_stored_procedures.out :::

The result set returned from the stored procedure can be accessed using `queryResult` variable in `sql:ProcedureCallResult`.
This can be processed as below,

::: code process_result_stream.bal :::

Further the result set can be mapped directly to a Ballerina record as follows,

::: code process_student_stream.bal :::

If the procedure returns more than one result set, then those can be accessed by using,
```ballerina
boolean isAvailable = getNextQueryResult();
```
This will return whether next result set is available and update `queryResult` with the next result set.

The following util files will initialize the test database before running the BBE and clean it up afterward.

::: code initialize.bal :::

::: code cleanup.bal :::
