
public function main() returns error? {
    Client rainierClient = check new ();
    OrderItem orderItem1 = {
        orderId: "order-1",
        itemId: "item-1",
        quantity: 5,
        notes: "none"
    };
    [string, string][] ids = check rainierClient->/orderitems.post([orderItem1]);
}
