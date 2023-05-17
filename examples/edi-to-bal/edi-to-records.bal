import ballerina/io;
import edi_to_bal.sorder;

public function main() returns error? {
    string ediText = check io:fileReadString("resources/order1.edi");
    sorder:SimpleOrder simpleOrder = check sorder:fromEdiString(ediText);
    io:println(string `Order Id: ${simpleOrder.header.orderId}`);

    foreach sorder:Items_Type item in simpleOrder.items {
        io:println(string `Item: ${item.item}, Quantity: ${item.quantity}`);
    }
}
