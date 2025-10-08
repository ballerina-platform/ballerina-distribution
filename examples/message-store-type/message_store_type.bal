import ballerina/log;
import ballerina/messaging;
import ballerina/uuid;

// Custom message store implementation using a simple in-memory map
isolated client class CustomMessageStore {
    *messaging:Store;

    private final map<readonly & messaging:Message> messages = {};
    private final map<readonly & messaging:Message> pendingMessages = {};

    isolated remote function store(anydata payload) returns error? {
        string id = uuid:createType1AsString();

        lock {
            self.messages[id] = {
                id,
                payload: payload.cloneReadOnly()
            };
        }

        log:printInfo("Message stored", id = id);
    }

    isolated remote function retrieve() returns messaging:Message|error? {
        lock {
            string[] keys = self.messages.keys();
            if keys.length() > 0 {
                string id = keys[0];
                readonly & messaging:Message message = self.messages.get(id);
                // Move message to pending state
                self.pendingMessages[id] = message;
                _ = self.messages.remove(id);
                return message;
            }
            return;
        }
    }

    isolated remote function acknowledge(string id, boolean success = true) returns error? {
        lock {
            if self.pendingMessages.hasKey(id) {
                if success {
                    _ = self.pendingMessages.remove(id);
                    log:printInfo("Message acknowledged", id = id);
                } else {
                    // Move message back to available state for negative ack
                    readonly & messaging:Message message = self.pendingMessages.get(id);
                    self.messages[id] = message;
                    _ = self.pendingMessages.remove(id);
                    log:printInfo("Message negative acknowledged", id = id);
                }
            }
        }
    }
}

public function main() returns error? {
    // Create an instance of the custom message store
    messaging:Store customStore = new CustomMessageStore();

    // Store and process a message
    check customStore->store("Hello, World!");

    messaging:Message? msg = check customStore->retrieve();
    if msg is messaging:Message {
        log:printInfo("Retrieved message", payload = msg.payload, id = msg.id);
        // Acknowledge the message
        check customStore->acknowledge(msg.id);
    }

    // Demonstrate negative acknowledgment
    check customStore->store("Test message");
    msg = check customStore->retrieve();
    if msg is messaging:Message {
        log:printInfo("Retrieved message for negative ack", payload = msg.payload, id = msg.id);
        check customStore->acknowledge(msg.id, false);

        // Retrieve the same message again after negative ack
        msg = check customStore->retrieve();
        if msg is messaging:Message {
            log:printInfo("Message available again after negative ack", payload = msg.payload, id = msg.id);
            check customStore->acknowledge(msg.id);
        }
    }
}
