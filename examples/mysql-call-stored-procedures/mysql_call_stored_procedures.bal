import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;
import ballerinax/mysql.driver as _;

// The `Student` record to represent the database table.
type Student record {
    int id;
    int age;
    string name;
};

public function main() returns error? {

    // Initializes the MySQL client. The `mysqlClient` can be reused to access the database throughout the application execution.
    mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
                                          password = "Test@123", database = "STUDENT");

    // Initializes the `INOUT` and `OUT` parameters for the procedure call.
    sql:InOutParameter id = new (1);
    sql:IntegerOutParameter totalCount = new;

    // The stored procedure is invoked.
    sql:ProcedureCallResult result = check mysqlClient->call(`{CALL GetCount(${id}, ${totalCount})}`);

    // Process procedure-call parameters.
    int studentId = check id.get();
    int total = check totalCount.get();

    io:println(`Age of the student with id '1' : ${studentId}`);
    io:println(`Total student count: ${total}`);

    // Closes the procedure call result to release the resources.
    check result.close();

    // Closes the MySQL client.
    check mysqlClient.close();

}
