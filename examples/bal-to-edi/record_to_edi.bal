import ballerina/io;
import edi_to_bal.sorder;

public function main() returns error? {
    sorder:SimpleOrder simpleOrder = 
        {header: {code: "HDR", orderId: "ORDER_200", organization: "HMart", date: "17-05-2023"}};
    simpleOrder.items.push({code: "ITM", item: "A680", quantity: 15}); 
    simpleOrder.items.push({code: "ITM", item: "A530", quantity: 2}); 
    simpleOrder.items.push({code: "ITM", item: "A500", quantity: 4});
    string ediText = check sorder:toEdiString(simpleOrder);
    io:println(ediText);
}
