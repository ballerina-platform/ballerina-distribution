import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Initializes the database as a prerequisite to `Change Data Capture` samples.
public function main() returns sql:Error? {
    mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
        password = "Test@123"
    );

    // Creates a database.
    _ = check mysqlClient->execute(`CREATE DATABASE finance_db;`);

    // Creates `transactions` table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE finance_db.transactions (
                                        tx_id INT AUTO_INCREMENT PRIMARY KEY,
                                        user_id INT,
                                        amount DECIMAL(10,2),
                                        status VARCHAR(50),
                                        created_at DATETIME
                                    )`);

    // Adds the records to the `transactions` table.
    _ = check mysqlClient->execute(`INSERT INTO finance_db.transactions (user_id, amount, status, created_at)
                                    VALUES(10, 9000.00, 'COMPLETED', '2025-04-01 08:00:00');`);
    _ = check mysqlClient->execute(`INSERT INTO finance_db.transactions (user_id, amount, status, created_at)
                                    VALUES(11, 12000.00, 'COMPLETED', '2025-04-01 08:10:00');`);
    _ = check mysqlClient->execute(`INSERT INTO finance_db.transactions (user_id, amount, status, created_at) 
                                    VALUES(12, 4500.00, 'PENDING', '2025-04-01 08:30:00');`);

    check mysqlClient.close();
}
