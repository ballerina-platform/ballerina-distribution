import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Initializes the database as a prerequisite to `Database Access - Query with advanced mapping` sample.
public function main() returns sql:Error? {
    mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
                                          password = "Test@123");

    // Creates a database.
    _ = check mysqlClient->execute(`CREATE DATABASE MUSIC_STORE;`);

    // Creates a table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE MUSIC_STORE.artists (
                                      artist_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                      first_name VARCHAR(300),
                                      last_name VARCHAR(300)
                                    );`);

    // Adds the records to the newly-created table.
    _ = check mysqlClient->execute(`INSERT INTO MUSIC_STORE.artists
                                    VALUES (1, "Beyonce", "Knowles");`);
    _ = check mysqlClient->execute(`INSERT INTO MUSIC_STORE.artists
                                    VALUES (2, "Rihanna", "Fenty");`);

    check mysqlClient.close();
}
