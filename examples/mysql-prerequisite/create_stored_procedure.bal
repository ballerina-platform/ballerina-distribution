import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Initializes the database as a prerequisite to `Database Access - Call stored procedures` sample.
public function main() returns sql:Error? {
    mysql:Client mysqlClient = check new ("localhost", "root", "Test@123", "MUSIC_STORE", 3306);

    // Creates the necessary stored procedures using the execute command.
    _ = check mysqlClient->execute(`CREATE PROCEDURE MUSIC_STORE.get_sales_order(INOUT date DATE, OUT totalCount INT)
                                    BEGIN
                                    	SELECT count(id) INTO totalCount FROM sales_order WHERE order_date = date;
                                        SELECT * FROM sales_order WHERE order_date = date;
                                    END`);

    check mysqlClient.close();
}
