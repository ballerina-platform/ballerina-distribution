import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Initializes the database as a prerequisite to `Database Access` samples.
public function main() returns sql:Error? {
    mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
                                          password = "Test@123");

    // Creates a database.
    _ = check mysqlClient->execute(`CREATE DATABASE MUSIC_STORE;`);

    // Creates `albums` table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE MUSIC_STORE.albums (
                                        id VARCHAR(100) NOT NULL PRIMARY KEY,
                                        title VARCHAR(100),
                                        artist VARCHAR(100),
                                        price REAL
                                    );`);

    // Adds the records to the `albums` table.
    _ = check mysqlClient->execute(`INSERT INTO MUSIC_STORE.albums
                                    VALUES("A-123", "Lemonade", "Beyonce", 18.98);`);
    _ = check mysqlClient->execute(`INSERT INTO MUSIC_STORE.albums
                                    VALUES("A-321", "Renaissance", "Beyonce", 24.98);`);

    // Creates `artists` table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE MUSIC_STORE.artists (
                                      artist_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                      first_name VARCHAR(300),
                                      last_name VARCHAR(300)
                                    );`);

    // Adds the records to the `artists` table.
    _ = check mysqlClient->execute(`INSERT INTO MUSIC_STORE.artists
                                    VALUES (1, "Beyonce", "Knowles");`);
    _ = check mysqlClient->execute(`INSERT INTO MUSIC_STORE.artists
                                    VALUES (2, "Rihanna", "Fenty");`);

    // Creates `inventory` in the database.
    _ = check mysqlClient->execute(`CREATE TABLE MUSIC_STORE.inventory (
                                      id varchar(100) NOT NULL PRIMARY KEY,
                                      title varchar(100) DEFAULT NULL,
                                      artist varchar(100) DEFAULT NULL,
                                      price double DEFAULT NULL,
                                      quantity int NOT NULL,
                                      CHECK (quantity > 0)
                                    );`);

    // Adds the records to the `inventory` table.
    _ = check mysqlClient->execute(`INSERT INTO MUSIC_STORE.inventory
                                    VALUES ("A-123", "Lemonade", "Beyonce", 18.98, 10);`);
    _ = check mysqlClient->execute(`INSERT INTO MUSIC_STORE.inventory
                                    VALUES ("A-321", "Renaissance", "Beyonce", 24.98, 100);`);

    // Creates `sales_order` table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE MUSIC_STORE.sales_order (
                                      id varchar(100) NOT NULL PRIMARY KEY,
                                      order_date DATE NOT NULL,
                                      product_id varchar(100) NOT NULL,
                                      quantity int
                                    );`);

    // Adds the records to the `sales_order` table.
    _ = check mysqlClient->execute(`INSERT INTO inventory VALUES
                                    ("A-123", "Lemonade", "Beyonce", 18.98, 10);`);
    _ = check mysqlClient->execute(`INSERT INTO inventory VALUES
                                    ("A-321", "Renaissance", "Beyonce", 24.98, 100);`);

    check mysqlClient.close();
}
