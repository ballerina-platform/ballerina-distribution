import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Insert test data for `Change Data Capture` samples.
public function main() returns sql:Error? {
    mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
        password = "Test@123"
    );

    // Adds the records to the `transactions` table.
    _ = check mysqlClient->execute(`INSERT INTO finance_db.transactions (user_id, amount, status, created_at)
                                    VALUES (11, 2000.00, 'COMPLETED', '2025-04-01 08:10:00');`);
    _ = check mysqlClient->execute(`INSERT INTO finance_db.transactions (user_id, amount, status, created_at)
                                    VALUES (11, 12000.00, 'COMPLETED', '2025-04-01 08:10:00');`);

    check mysqlClient.close();
}
