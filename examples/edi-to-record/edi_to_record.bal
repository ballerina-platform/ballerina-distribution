import ballerina/io;
import edi_to_record.sorder;

public function main() returns error? {
    string ediText = check io:fileReadString("resources/order.edi");
    sorder:SimpleOrder simpleOrder = check sorder:fromEdiString(ediText);
    io:println("Order Id: ", simpleOrder.header.orderId);

    foreach sorder:Items_Type item in simpleOrder.items {
        io:println("Item: ", item.item, ", Quantity: ", item.quantity);
    }
}
