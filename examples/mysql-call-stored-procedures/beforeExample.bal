import ballerina/io;
import ballerina/sql;
import ballerinax/mysql;

// The username and password of the MySQL database and database
// name which is to be created to execute the sample.
// You can change these based on your setup.
string dbUser = "DB_USER_NAME";
string dbPassword = "DB_PASSWORD";
string dbName = "DB_NAME";

public function main() returns error? {
    io:println("\nCreating the prerequisites...!");
    // Initializes the client without any database to create the database.
    mysql:Client sqlClient = check new (user = dbUser, password = dbPassword);

    // Creates the database if it does not exist. If any error occurred,
    // the error will be returned.
    sql:ExecutionResult result =
        check sqlClient->execute("CREATE DATABASE " + dbName);
    io:println("Database created. ");

    io:println("Creating necessary table and procedures...");

    // Initializes the MySQL client with created database. If any error occurred,
    // the error will be returned.
    sqlClient = check new (user = dbUser,
            password = dbPassword, database = dbName);

    // Creates the `Student` table` with the the `id` is an auto-generated column.
    // If any error occurred, the error will be returned.
    result = check sqlClient->execute("CREATE TABLE Student(" +
            " id INT AUTO_INCREMENT, age INT, name VARCHAR(255), " +
            " PRIMARY KEY (id))");
    io:println("Create Student table executed.");

    // Necessary stored procedures are created using the execute command.

    // Creates `InsertStudent` stored procedure. If any error occurred,
    // the error will be returned.
    result = check sqlClient->execute("CREATE PROCEDURE InsertStudent" +
        "(IN pName VARCHAR(255), IN pAge INT) " +
        "BEGIN " +
        "INSERT INTO Student(age, name) VALUES (pAge, pName); " +
        "END");
    io:println("Stored procedure with IN param created.");

    // Creates `GetCount` stored procedure. If any error occurred,
    // the error will be returned.
    result = check sqlClient->execute("CREATE PROCEDURE GetCount" +
        "(INOUT pID INT, OUT totalCount INT) " +
        "BEGIN " +
        "SELECT age INTO pID FROM Student WHERE id = pID; " +
        "SELECT COUNT(*) INTO totalCount FROM Student;" +
        "END");
    io:println("Stored procedure with INOUT/OUT param created.");

    // Creates `GetStudents` stored procedure. If any error occurred,
    // the error will be returned.
    result = check sqlClient->execute("CREATE PROCEDURE GetStudents() " +
        "BEGIN SELECT * FROM Student; END");
    io:println("Stored procedure with result set returned created.");

    io:println("\nSetup successfully done!");

    // Closes the client.
    check sqlClient.close();
}
