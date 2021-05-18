import ballerina/io;
import ballerina/sql;
import ballerinax/mysql;

// The username and password of the MySQL database and database
// name which is used to execute this sample. You can change these
// based on your setup.
string dbUser = "DB_USER_NAME";
string dbPassword = "DB_PASSWORD";
string dbName = "DB_NAME";

// Initializes the MySQL client to be used for the
// procedure call executions.
mysql:Client sqlClient = check new (user = dbUser,
    password = dbPassword, database = dbName);

// The stored procedure `InsertStudent` with the IN parameters is invoked.
function insertRecord() returns error? {

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
    check retCall.close();
}

// Here, the stored procedure with the OUT and INOUT parameters is invoked.
function getCount() returns error? {

    io:println("\nInvoke `GetCount` procedure with INOUT & OUT params");

    // Initializes the INOUT & OUT parameters.
    sql:InOutParameter id = new (1);
    sql:IntegerOutParameter totalCount = new;
    sql:ParameterizedCallQuery sqlQuery =
                        `{CALL GetCount(${id}, ${totalCount})}`;

    // Executes the stored procedure.
    sql:ProcedureCallResult retCall = check sqlClient->call(sqlQuery);
    io:println("Call stored procedure `GetCount` is successful.");
    io:println("Age of the student with id '1' : ", id.get(int));
    io:println("Total student count: ", totalCount.get(int));
    check retCall.close();
}

// Student record to represent the database table.
type Student record {
    int id;
    int age;
    string name;
};

// Invokes the stored procedure, which returns data.
function checkData() returns error? {

    io:println("\nInvoke `GetStudents` procedure with returned data");

    // Executes the stored procedure.
    sql:ProcedureCallResult retCall = check
                            sqlClient->call("{CALL GetStudents()}", [Student]);
    io:println("Call stored procedure `InsertStudent` is successful.");

    // Process the returned result stream.
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
    check retCall.close();
}

public function main() returns error? {
    io:println("\nStarts to run the sample!");

    // Inserts a record by calling a procedure.
    check insertRecord();

    // Gets the total count by calling a procedure.
    check getCount();

    // Gets all the results by invoking a procedure.
    check checkData();

    io:println("\nSample executed successfully!");

    // Closes the client.
    check sqlClient.close();
}
