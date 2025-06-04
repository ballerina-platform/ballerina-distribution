import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Insert test data for `Change Data Capture` samples.
public function main() returns sql:Error? {
    mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
        password = "Test@123"
    );

    _ = check mysqlClient->execute(
        `UPDATE store_db.products SET price = price * 0.9 WHERE id = 1002;`
        );
    _ = check mysqlClient->execute(
        `UPDATE store_db.product_reviews SET rating = rating - 1 WHERE product_id = 1002;`
        );
    _ = check mysqlClient->execute(
        `INSERT store_db.products VALUES (1003, "Samsung Galaxy S20", 499.99, "Old Smartphone", 2);`
        );
    _ = check mysqlClient->execute(
        `DELETE FROM store_db.products WHERE id = 1003;`
        );

    check mysqlClient.close();
}
