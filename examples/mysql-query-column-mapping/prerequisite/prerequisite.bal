import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Initializes the database as a prerequisite to `Database Access - Query with advanced mapping` sample.
public function main() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = "root", password = "Test@123");

    // Creates a database.
    _ = check mysqlClient->execute(`CREATE DATABASE CUSTOMER`);

    // Creates a table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE CUSTOMER.Customers
            (customer_id INTEGER NOT NULL AUTO_INCREMENT, first_name
            VARCHAR(300), last_name  VARCHAR(300),
            PRIMARY KEY (customer_id))`);

    // Adds the records to the newly-created table.
    _ = check mysqlClient->execute(`INSERT INTO CUSTOMER.Customers
            (first_name, last_name) VALUES ('Peter','Stuart')`);
    _ = check mysqlClient->execute(`INSERT INTO CUSTOMER.Customers
            (first_name, last_name) VALUES ('Dan', 'Brown')`);

    check mysqlClient.close();
}
