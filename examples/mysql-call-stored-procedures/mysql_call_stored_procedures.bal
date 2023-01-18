import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// The `Order` record to load records from `sales_order` table.
type Order record {|
    string id;
    @sql:Column {name: "order_date"}
    string orderDate;
    @sql:Column {name: "product_id"}
    string productId;
    int quantity;
|};

type Orders record {|
    int total;
    Order[] orders;
|};

service / on new http:Listener(8080) {
    private final mysql:Client db;

    function init() returns error? {
        // Initiate the mysql client at the start of the service. This will be used
        // throughout the lifetime of the service.
        self.db = check new ("localhost", "root", "Test@123", "MUSIC_STORE", 3306);
    }

    resource function get orders/[string orderDate]() returns Orders|error {
        // Initializes the `INOUT` and `OUT` parameters for the procedure call.
        sql:DateValue filterDate = new (orderDate);
        sql:IntegerOutParameter total = new ();

        // Call the `get_sales_order` stored procedure.
        sql:ProcedureCallResult result =
            check self.db->call(`{CALL get_sales_order(${filterDate}, ${total})}`, [Order]);

        // Process procedure-call parameters.
        int totalCount = check total.get();

        Order[] orders = [];
        // Process procedure-call query results.
        stream<record {}, error?>? resultStream = result.queryResult;
        if resultStream !is () {
            stream<Order, error?> orderStream = <stream<Order, error?>>resultStream;
            orders = check from Order 'order in orderStream
                select 'order;
        }

        // Cleans up the resources.
        check result.close();

        return {
            total: totalCount,
            orders: orders
        };
    }
}
