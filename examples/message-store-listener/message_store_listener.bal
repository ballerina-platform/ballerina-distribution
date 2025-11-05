import ballerina/messaging;
import ballerina/log;

// Create the main message store
messaging:Store msgStore = new messaging:InMemoryMessageStore();

// Create the dead-letter message store
messaging:Store dlStore = new messaging:InMemoryMessageStore();

// Create the message store listener
listener messaging:StoreListener msgStoreListener = new (msgStore, {
    pollingInterval: 10,
    maxRetries: 2,
    retryInterval: 2,
    deadLetterStore: dlStore
});

// Create the service to process messages
service on msgStoreListener {
    isolated remote function onMessage(anydata payload) returns error? {
        log:printInfo("message received", payload = payload);

        // Simulate error scenario
        if payload == "error" {
            return error("Simulated processing error");
        }
    }
}

public function main() returns error? {
    // Store a message
    check msgStore->store("Hello, World!");

    // Store a message to simulate error scenario
    check msgStore->store("error");
}
