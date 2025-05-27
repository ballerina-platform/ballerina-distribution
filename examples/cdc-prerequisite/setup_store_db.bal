import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Initializes the database as a prerequisite to `Change Data Capture` samples.
public function main() returns sql:Error? {
    mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
        password = "Test@123"
    );

    // Creates a database.
    _ = check mysqlClient->execute(`CREATE DATABASE store_db;`);

    // Creates `vendors` table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE store_db.vendors (
                                        id INT PRIMARY KEY,
                                        name VARCHAR(255),
                                        contact_info TEXT
                                    );`);

    // Adds the records to the `vendors` table.
    _ = check mysqlClient->execute(`INSERT INTO store_db.vendors VALUES (1, 'Samsung', 'contact@samsung.com');`);
    _ = check mysqlClient->execute(`INSERT INTO store_db.vendors VALUES (2, 'Apple', 'contact@apple.com');`);

    // Creates `products` table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE store_db.products (
                                        id INT PRIMARY KEY,
                                        name VARCHAR(255),
                                        price DECIMAL(10,2),
                                        description TEXT,
                                        vendor_id INT,
                                        FOREIGN KEY (vendor_id) REFERENCES vendors(id)
                                    );`);

    // Adds the records to the `products` table.
    _ = check mysqlClient->execute(`INSERT INTO store_db.products VALUES (1001, 'Samsung Galaxy S24', 999.99, 'Flagship phone with AI camera', 1);`);
    _ = check mysqlClient->execute(`INSERT INTO store_db.products VALUES (1002, 'Apple iPhone 15 Pro', 1099.00, 'New titanium design', 2);`);

    // Creates `product_reviews` table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE store_db.product_reviews (
                                        review_id INT PRIMARY KEY,
                                        product_id INT,
                                        rating INT CHECK (rating BETWEEN 1 AND 5),
                                        comment TEXT,
                                        FOREIGN KEY (product_id) REFERENCES products(id)
                                    );`);

    // Adds the records to the `product_reviews` table.
    _ = check mysqlClient->execute(`INSERT INTO store_db.product_reviews VALUES (1, 1001, 5, 'Amazing camera');`);
    _ = check mysqlClient->execute(`INSERT INTO store_db.product_reviews VALUES (2, 1001, 4, 'Great battery life');`);
    _ = check mysqlClient->execute(`INSERT INTO store_db.product_reviews VALUES (3, 1002, 5, 'Best iPhone yet');`);

    check mysqlClient.close();
}
