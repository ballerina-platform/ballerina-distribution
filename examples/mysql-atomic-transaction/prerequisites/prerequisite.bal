import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Initializes the database as a prerequisite to `Database Access - Batch execution` sample.
public function main() returns sql:Error? {
    mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
                                          password = "Test@123");

    // Creates a database.
    _ = check mysqlClient->execute(`CREATE DATABASE MUSIC_STORE;`);

    // Creates a table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE MUSIC_STORE.inventory (
                                      id varchar(100) NOT NULL PRIMARY KEY,
                                      title varchar(100) DEFAULT NULL,
                                      artist varchar(100) DEFAULT NULL,
                                      price double DEFAULT NULL,
                                      quantity int NOT NULL,
                                      CHECK (quantity > 0)
                                    );`);

    // Adds the records to the newly-created table.
    _ = check mysqlClient->execute(`INSERT INTO MUSIC_STORE.inventory
                                    VALUES ("A-123", "Lemonade", "Beyonce", 18.98, 10);`);
    _ = check mysqlClient->execute(`INSERT INTO MUSIC_STORE.inventory
                                    VALUES ("A-321", "Renaissance", "Beyonce", 24.98, 100);`);

    // Creates a table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE MUSIC_STORE.sales_order(
                                      id varchar(100) NOT NULL PRIMARY KEY,
                                      order_date DATE NOT NULL,
                                      product_id varchar(100) NOT NULL,
                                      quantity int
                                    );`);
    _ = check mysqlClient->execute(`INSERT INTO inventory VALUES
                                    ("A-123", "Lemonade", "Beyonce", 18.98, 10);`);
    _ = check mysqlClient->execute(`INSERT INTO inventory VALUES
                                    ("A-321", "Renaissance", "Beyonce", 24.98, 100);`);
    check mysqlClient.close();
}
