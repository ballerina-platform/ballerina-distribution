import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;

// The `Student` record to represent the database table.
type Student record {
    int id;
    int age;
    string name;
};

public function main() returns error? {
    // Runs the prerequisite setup for the example.
    check initialize();

    // Initializes the MySQL client. The `mysqlClient` can be reused to access the database throughout the application execution.
    mysql:Client mysqlClient = check new (user = "root",
            password = "Test@123", database = "STUDENT");

    // Initializes the `INOUT` and `OUT` parameters for the procedure call.
    sql:InOutParameter id = new (1);
    sql:IntegerOutParameter totalCount = new;

    // The stored procedure is invoked.
    sql:ProcedureCallResult result =
        check mysqlClient->call(`{CALL GetCount(${id}, ${totalCount})}`);

    // Process procedure-call parameters.
    int studentId = check id.get();
    int total = check totalCount.get();

    io:println(`Age of the student with id '1' : ${studentId}`);
    io:println(`Total student count: ${total}`);

    // Closes the procedure call result to release the resources.
    check result.close();

    // Closes the MySQL client.
    check mysqlClient.close();

    // Performs the cleanup after the example.
    check cleanup();
}

// Initializes the database as a prerequisite to the example.
function initialize() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123");

    // Creates a database.
    _ = check mysqlClient->execute(`CREATE DATABASE STUDENT`);

    // Creates a table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE STUDENT.Student
            (id INT AUTO_INCREMENT, age INT, name VARCHAR(255),
            PRIMARY KEY (id))`);

    // Creates the necessary stored procedures using the execute command.
    _ = check mysqlClient->execute(`CREATE PROCEDURE STUDENT.GetCount
        (INOUT pID INT, OUT totalCount INT) BEGIN SELECT age INTO pID FROM
        Student WHERE id = pID; SELECT COUNT(*) INTO totalCount FROM Student;
        END`);
    // Inserts necessary data.
    _ = check mysqlClient->execute(`INSERT INTO STUDENT.Student(name, age)
                                        VALUES ('George', 24)`);

    check mysqlClient.close();
}

// Cleans up the database after running the example.
function cleanup() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123");

    // Cleans the database.
    _ = check mysqlClient->execute(`DROP DATABASE STUDENT`);

    // Closes the MySQL client.
    check mysqlClient.close();
}
