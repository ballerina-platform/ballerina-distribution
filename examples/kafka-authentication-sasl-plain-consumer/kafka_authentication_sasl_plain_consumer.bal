import ballerinax/kafka;
import ballerina/log;

// Define the relevant SASL URL of the configured Kafka server.
const string SASL_URL = "localhost:9093";

kafka:ConsumerConfiguration consumerConfigs = {
    groupId: "test-group",
    topics: ["demo-security"],
    // Provide the relevant authentication configurations to authenticate the consumer by [`kafka:AuthenticationConfiguration`](https://docs.central.ballerina.io/ballerinax/kafka/latest/records/AuthenticationConfiguration).
    auth: {
        // Provide the authentication mechanism used by the Kafka server.
        mechanism: kafka:AUTH_SASL_PLAIN,
        // Username and password should be set here in order to authenticate the consumer.
        // For information on how to secure values instead of directly using plain text values, see [Defining Configurable Variables](https://ballerina.io/learn/user-guide/configurability/defining-configurable-variables/#securing-sensitive-data-using-configurable-variables).
        username: "alice",
        password: "alice@123"
    },
    securityProtocol: kafka:PROTOCOL_SASL_PLAINTEXT
};

// Create a subtype of `kafka:AnydataConsumerRecord`
public type StringConsumerRecord record {|
    *kafka:AnydataConsumerRecord;
    string value;
|};

service on new kafka:Listener(SASL_URL, consumerConfigs) {
    remote function onConsumerRecord(StringConsumerRecord[] records)
    returns error? {
        check from StringConsumerRecord 'record in records
            do {
                log:printInfo("Received message: " + 'record.value);
            };
    }
}
