import ballerina/constraint;
import ballerinax/kafka;
import ballerina/io;

public type Order record {
    int orderId;
    // Add a constraint to only allow string values of length between 30 and 1.
    @constraint:String {maxLength: 30, minLength: 1}
    string productName;
    decimal price;
    boolean isValid;
};

public function main() returns error? {
    kafka:Consumer orderConsumer = check new (kafka:DEFAULT_URL, {
        groupId: "order-group-id",
        topics: "order-topic"
    });

    while true {
        Order[] orders = check orderConsumer->pollPayload(15);
        check from Order 'order in orders
            where 'order.isValid
            do {
                io:println(string `Received valid order for ${'order.productName}`);
            };
    }
}
