import ballerina/sql;
import ballerinax/mysql;

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
        SELECT * FROM STUDENT; END`);
    // Inserts the necessary data.
    _ = check mysqlClient->execute(`INSERT INTO STUDENT.Student(name, age)
                                        VALUES ('George', 24)`);

    check mysqlClient.close();
}
