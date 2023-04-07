import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// The `Order` record to load records from `sales_order` table.
type Order record {|
    string id;
    string orderDate;
    string productId;
    int quantity;
|};

service / on new http:Listener(8080) {
    private final mysql:Client db;

    function init() returns error? {
        // Initiate the mysql client at the start of the service. This will be used
        // throughout the lifetime of the service.
        self.db = check new ("localhost", "root", "Test@123", "MUSIC_STORE", 3306);
    }

    resource function post 'order(Order salesOrder) returns http:Created|error {
        transaction {
            // Insert into the `sales_order` table.
            _ = check self.db->execute(`INSERT INTO MUSIC_STORE.sales_order VALUES 
                                        (${salesOrder.id}, ${salesOrder.orderDate},
                                         ${salesOrder.productId}, ${salesOrder.quantity});`);

            // Update product quantity as per the order.
            sql:ExecutionResult inventoryUpdate = check self.db->execute(
                                        `UPDATE inventory 
                                        SET quantity = quantity - ${salesOrder.quantity} 
                                        WHERE id = ${salesOrder.productId}`);

            // If the product is not found, rollback or commit transaction.
            if inventoryUpdate.affectedRowCount == 0 {
                rollback;
                return error(string `Product ${salesOrder.productId} not found.`);
            } else {
                check commit;
                return http:CREATED;
            }
        } on fail error e {
            // In case of error, the transaction block is rolled back automatically.
            if e is sql:DatabaseError {
                if e.detail().errorCode == 3819 {
                    return error(string `Product ${salesOrder.productId} is out of stock.`);
                }
            }
            return e;
        }
    }
}
