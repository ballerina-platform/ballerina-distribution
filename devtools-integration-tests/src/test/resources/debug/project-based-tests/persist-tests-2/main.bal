import persist_tests_2.foo;

public function main() returns error? {
    foo:Client rainierClient = check new ();
    foo:OrderItem orderItem1 = {
        orderId: "order-1",
        itemId: "item-1",
        quantity: 5,
        notes: "none"
    };
    [string, string][] ids = check rainierClient->/orderitems.post([orderItem1]);
}
