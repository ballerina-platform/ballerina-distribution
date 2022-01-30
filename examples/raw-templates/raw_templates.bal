import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/sql;

jdbc:Client dbClient = check new (url = "jdbc:h2:file:./master/orderdb",
                           user = "test", password = "test");

public function main() returns error? {
    // Uses a raw template to create `Orders` table.
    _ = check dbClient->execute(`CREATE TABLE IF NOT EXISTS Orders
                                (orderId INTEGER NOT NULL,
                                customerId INTEGER, noOfItems INTEGER,
                                PRIMARY KEY (orderId))`);
    // Uses a raw template to insert values to `Orders` table.
    _ = check dbClient->execute(`INSERT INTO Orders (orderId, customerId,
                                noOfItems) VALUES (1, 1, 20)`);
    _ = check dbClient->execute(`INSERT INTO Orders (orderId, customerId,
                                noOfItems) VALUES (2, 1, 15)`);

    stream<record {| anydata...; |}, sql:Error?> strm = getOrders(1);
    record {|record {} value;|}|sql:Error? v = strm.next();
    while (v is record {|record {} value;|}) {
        record {} value = v.value;
        io:println(value);
        v = strm.next();
    }
}

function getOrders(int customerId)
    returns stream<record {| anydata...; |}, sql:Error?> {
    // In this raw template, the `customerId` variable is interpolated in the literal.
    return dbClient->query(`SELECT * FROM orders
                          WHERE customerId = ${customerId}`);

}
