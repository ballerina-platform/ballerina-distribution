import ballerina/io;
import ballerina/xlsx;

type Order record {|
    string item;
    int quantity;
    decimal price;
|};

public function main() returns error? {
    Order[] orders = [
        {item: "Laptop", quantity: 2, price: 1250.00},
        {item: "Monitor", quantity: 5, price: 300.00}
    ];

    // Create a workbook with a sheet holding an Excel table.
    xlsx:Workbook wb = new;
    xlsx:Sheet ordersSheet = check wb.createSheet("Orders");
    _ = check ordersSheet.createTableFromData("OrdersTable", orders);
    check wb.saveAs("orders.xlsx");
    check wb.close();

    // A table is addressable by its name from anywhere in the workbook.
    Order[] rows = check xlsx:parseTable("orders.xlsx", "OrdersTable");
    io:println(rows);
}
