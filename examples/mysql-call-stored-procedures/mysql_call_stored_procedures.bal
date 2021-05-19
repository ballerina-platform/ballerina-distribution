import ballerina/io;
import ballerina/sql;
import ballerinax/mysql;

// The username and password of the MySQL database and the database
// name, which is used to execute this sample. You can change these
// based on your setup.
string dbUser = "DB_USER_NAME";
string dbPassword = "DB_PASSWORD";
string dbName = "DB_NAME";

// Student record to represent the database table.
type Student record {
    int id;
    int age;
    string name;
};

public function main() returns error? {

    // Initializes the MySQL client to be used for the
    // procedure call executions.
    mysql:Client sqlClient = check new (user = dbUser,
        password = dbPassword, database = dbName);

    io:println("\nStarts to run the sample!");

    // The `InsertStudent` stored procedure with the IN parameters is invoked.
    io:println("\nInvoke `InsertStudent` procedure with IN params");

    // Creates a parameterized query to invoke the procedure.
    string name = "George";
    int age = 24;
    sql:ParameterizedCallQuery sqlQuery =
                                `CALL InsertStudent(${name}, ${age})`;

    // Executes the stored procedure.
    sql:ProcedureCallResult retCall = check sqlClient->call(sqlQuery);
    io:println("Call stored procedure `InsertStudent` is successful : ",
                retCall.executionResult);

    // Gets the total count by calling a procedure.
    // Here, the stored procedure with the OUT and INOUT parameters is invoked.
    io:println("\nInvoke `GetCount` procedure with INOUT & OUT params");

    // Initializes the INOUT & OUT parameters.
    sql:InOutParameter id = new (1);
    sql:IntegerOutParameter totalCount = new;
    sqlQuery = `{CALL GetCount(${id}, ${totalCount})}`;

    // Executes the stored procedure.
    retCall = check sqlClient->call(sqlQuery);
    age = id.get(int);
    io:println("Age of the student with id '1' : ", age);

    // Gets the total count
    int totalCount = result.get(int);
    io:println("Total student count: ", totalCount);

    io:println("Call stored procedure `GetCount` is successful.");

    // Gets all the results by invoking a procedure.
    // Invokes the stored procedure, which returns the data.
    io:println("\nInvoke `GetStudents` procedure with returned data");

    // Executes the stored procedure.
    retCall = check sqlClient->call("{CALL GetStudents()}", [Student]);
    io:println("Call stored procedure `InsertStudent` is successful.");

    // Processes the returned result stream.
    stream<record{}, sql:Error>? result = retCall.queryResult;
    if (!(result is ())) {
        stream<Student, sql:Error> studentStream =
                                <stream<Student, sql:Error>> result;
        sql:Error? e = studentStream.forEach(function(Student student) {
                            io:println("Student details: ", student);
                        });
    } else {
        io:println("Empty result is returned from the `GetStudents`.");
    }
    io:println("Call stored procedure `GetStudents` is successful.");

    check retCall.close();

    io:println("\nSample executed successfully!");

    // Closes the client.
    check sqlClient.close();
}
