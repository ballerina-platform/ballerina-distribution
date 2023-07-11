import ballerina/io;

public function main() returns error? {
    var orders = [
        {orderId: 1, itemName: "A", price: 23.4, quantity: 2},
        {orderId: 1, itemName: "A", price: 20.4, quantity: 1},
        {orderId: 2, itemName: "B", price: 21.5, quantity: 3},
        {orderId: 1, itemName: "B", price: 21.5, quantity: 3}
    ];

    var items = from var {orderId, itemName} in orders
        // The `group by` clause create groups for each `orderId`.
        // The `itemName` is a non-grouping key and it becomes a sequence variable.
        group by orderId
        select [itemName];
    
    // List of items per `orderId`
    io:println(items);

    var quantities = from var {itemName, quantity} in orders
        // The `group by` clause create groups for each `itemName`.
        // The `quantity` is a non-grouping key and it becomes a sequence variable.
        group by itemName
        select {itemName, quantity: sum(quantity)};

    // List of quantity per item
    io:println(quantities);

    var income = from var {price, quantity} in orders
        let var totPrice = price*quantity
        // The `collect` clause creates a single group and all variables become
        // non-grouping keys
        collect sum(totPrice);
    
    // Total Income from orders
    io:println(income);
}
