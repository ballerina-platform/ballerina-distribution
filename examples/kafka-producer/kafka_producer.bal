import ballerinax/kafka;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

// Create a subtype of `kafka:AnydataProducerRecord`
public type OrderProducerRecord record {|
    *kafka:AnydataProducerRecord;
    Order value;
    int key;
|};

kafka:Producer orderProducer = check new (kafka:DEFAULT_URL);

public function main() returns error? {
    OrderProducerRecord producerRecord = {
        key: 1,
        topic: "test-kafka-topic",
        value: {
            orderId: 1,
            productName: "ABC",
            price: 27.5,
            isValid: true
        }
    };
    // Sends the message to the Kafka topic.
    check orderProducer->send(producerRecord);
}
