import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;

// The stored procedure `InsertStudent` with the IN parameters is invoked. 
function insertRecord(mysql:Client mysqlClient) returns sql:Error? {
    // Create a parameterized query to invoke the procedure.
    string name = "George";
    int age = 24;
    sql:ParameterizedCallQuery sqlQuery = 
                                `CALL InsertStudent(${name}, ${age})`;

    // Execute the stored procedure.
    sql:ProcedureCallResult retCall = check mysqlClient -> call(sqlQuery);
    io:println("Call stored procedure `InsertStudent`." +
        "\nAffected Row count: ", retCall.executionResult?.affectedRowCount);
    checkpanic retCall.close();
}

// Here, the stored procedure with the OUT and INOUT parameters is invoked.
function getCount(mysql:Client mysqlClient) returns sql:Error? {
    // Initialize the INOUT & OUT parameters.
    sql:InOutParameter id = new (1);
    sql:IntegerOutParameter totalCount = new;
    sql:ParameterizedCallQuery sqlQuery = 
                        `{CALL GetCount(${id}, ${totalCount})}`;

    // Execute the stored procedure.
    sql:ProcedureCallResult retCall = check mysqlClient -> call(sqlQuery);
    io:println("Call stored procedure `GetCount`.");
    io:println("Age of the student with id '1' : ", id.get(int));
    io:println("Total student count: ", totalCount.get(int));
    checkpanic retCall.close();
}

// Student record to represent the database table.
type Student record {
    int id;
    int age;
    string name;
};

// Invoke the stored procedure, which returns data.
function checkData(mysql:Client sqlClient) returns sql:Error? {
    // Execute the stored procedure.
    sql:ProcedureCallResult retCall = 
            check sqlClient->call("{CALL GetStudents()}", [Student]);
    io:println("Call stored procedure `GetStudents`.");              

    // Process the returned result stream.
    stream<record{}, sql:Error>? result = retCall.queryResult;
    if result is stream<record{}, sql:Error> {
        stream<Student, sql:Error> studentStream = 
                <stream<Student, sql:Error>> result;
        sql:Error? e = studentStream.forEach(function(Student student) {
            io:println("Student details: ", student);
        });
    }
    checkpanic retCall.close();
}

// Initializes the database as the prerequisite to the example.
function beforeRunningExample() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123");

    // Create a Database.
    sql:ExecutionResult result =
        check mysqlClient -> execute(`CREATE DATABASE MYSQL_BBE`);

    // Create a table in the database.
    result = check mysqlClient -> execute(`CREATE TABLE MYSQL_BBE.Student( id INT 
            AUTO_INCREMENT, age INT, name VARCHAR(255),PRIMARY KEY (id))`);

    // Create necessary stored procedures using the execute command.
    result = check mysqlClient -> execute(`CREATE PROCEDURE MYSQL_BBE.InsertStudent
        (IN pName VARCHAR(255), IN pAge INT) BEGIN INSERT INTO Student(age, name) 
        VALUES (pAge, pName); END`);
    result = check mysqlClient -> execute(`CREATE PROCEDURE MYSQL_BBE.GetCount(INOUT 
        pID INT, OUT totalCount INT) BEGIN SELECT age INTO pID FROM Student 
        WHERE id = pID; SELECT COUNT(*) INTO totalCount FROM Student; END`);   
    result = check mysqlClient -> execute(`CREATE PROCEDURE MYSQL_BBE.GetStudents() 
        BEGIN SELECT * FROM Student; END`);

    check mysqlClient.close();    
}

// Cleans up the database after running the example.
function afterRunningExample(mysql:Client mysqlClient) returns sql:Error? {
    // Clean the database.
    sql:ExecutionResult result =
            check mysqlClient -> execute(`DROP DATABASE MYSQL_BBE`);

    // Close the MySQL client.
    check mysqlClient.close();
}

public function main() returns error? {
    // Run the prerequisite setup for the example.
    check beforeRunningExample();

    // Initialize the MySQL client.
    mysql:Client mysqlClient = check new (user = "root",
            password = "Test@123", database = "MYSQL_BBE");

    // Insert a record by calling a procedure.
    check insertRecord(mysqlClient);

    // Get the total count by calling a procedure.
    check getCount(mysqlClient);
                
    // Get all the results by invoking a procedure.
    check checkData(mysqlClient);

    // Performs cleanup after the example.
    check afterRunningExample(mysqlClient);
}
