import ballerina/io;
import ballerina/workflow;

type Payment record {|
    decimal amount;
|};

@workflow:Activity
function shipOrder(string orderId) returns string|error {
    io:println("Shipping order ", orderId);
    return "SHIPPED";
}

// The third parameter declares the data events that the workflow accepts.
// Each field is a named channel, typed as a `future`.
@workflow:Workflow
function processOrder(workflow:Context ctx, string orderId,
        record {|future<Payment> payment;|} events) returns string|error {
    // Pause durably until the `payment` data arrives.
    Payment payment = check wait events.payment;
    string status = check ctx->callActivity(shipOrder, {orderId});
    return string `Paid ${payment.amount}, ${status}`;
}

public function main() returns error? {
    string id = check workflow:run(processOrder, "ORD-001");

    // Send data to the running instance on its `payment` channel. A service,
    // a message listener, or any other caller can send data the same way.
    check workflow:sendData(processOrder, id, "payment", {amount: 100});

    string result = check workflow:waitForResult(id);
    io:println(result);
}
