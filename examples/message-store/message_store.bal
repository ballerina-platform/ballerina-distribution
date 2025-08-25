import ballerina/messaging;
import ballerina/io;

public isolated client class CustomStore {
    *messaging:Store;
    
    isolated remote function store(anydata message) returns error? {
        // Custom implementation to store the message
    }

    isolated remote function retrieve() returns messaging:Message|error? {
        // Custom implementation to retrieve a message
    }

    isolated remote function acknowledge(string id, boolean success = true) returns error? {
        // Custom implementation to acknowledge a message
    }
}

// Using the in-memory message store implementation
final messaging:Store store = new messaging:InMemoryMessageStore();

public function main() returns error? {
    // Store a message
    check store->store("Hello, World");
    
    // Retrieve the message
    messaging:Message? msg = check store->retrieve();
    if msg is messaging:Message {
        io:println("Retrieved message: ", msg.payload, " with id: ", msg.id);
        
        // Acknowledge the message with success will remove the message from
        // the store
        check store->acknowledge(msg.id);
    }

    // Try to retrieve the message again
    msg = check store->retrieve();
    if msg is () {
        io:println("No messages in the store");
    }
}
