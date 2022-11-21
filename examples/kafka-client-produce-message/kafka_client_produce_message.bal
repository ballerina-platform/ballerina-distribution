import ballerinax/kafka;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

public function main() returns error? {
    kafka:Producer orderProducer = check new (kafka:DEFAULT_URL);

    // Sends the message to the Kafka topic.
    check orderProducer->send({
        topic: "test-kafka-topic",
        value: {
            orderId: 1,
            productName: "ABC",
            price: 27.5,
            isValid: true
        }
    });
}
