import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Initializes the database as a prerequisite to `Database Access - Simple query` sample.
public function main() returns sql:Error? {
    mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
                                          password = "Test@123");

    // Creates a database.
    _ = check mysqlClient->execute(`CREATE DATABASE MUSIC_STORE;`);

    // Creates a table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE MUSIC_STORE.albums (
                                    	id VARCHAR(100) NOT NULL PRIMARY KEY,
                                        title VARCHAR(100),
                                        artist VARCHAR(100),
                                        price REAL
                                    );`);

    // Adds the records to the newly-created table.
    _ = check mysqlClient->execute(`INSERT INTO MUSIC_STORE.albums
                                    VALUES("A-123", "Lemonade", "Beyonce", 18.98);`);
    _ = check mysqlClient->execute(`INSERT INTO MUSIC_STORE.albums
                                    VALUES("A-321", "Renaissance", "Beyonce", 24.98);`);

    check mysqlClient.close();
}
