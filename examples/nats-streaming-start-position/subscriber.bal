import ballerina/log;
import ballerinax/stan;

// Initializes the NATS Streaming listener.
listener stan:Listener lis = new(stan:DEFAULT_URL);

// Binds the consumer to listen to the messages published to the 'demo' subject.
// By default, only new messages are received.
@stan:ServiceConfig {
    subject: "demo"
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) {
        // Prints the incoming message in the console.
        string|error messageData = string:fromBytes(message.content);
        if messageData is string {
            log:printInfo("Message Received to service receiveNewOnly: "
                + messageData);
        }
    }
}

// Binds the consumer to listen to the messages published to the 'demo' subject.
// Receives all the messages from the beginning.
@stan:ServiceConfig {
    subject: "demo",
    startPosition: stan:FIRST
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) {
        // Prints the incoming message in the console.
        string|error messageData = string:fromBytes(message.content);
        if messageData is string {
            log:printInfo("Message Received to service receiveFromBegining: "
                + messageData);
        }
    }
}

// Binds the consumer to listen to the messages published to the 'demo' subject.
// Receives messages starting from the last received message.
@stan:ServiceConfig {
    subject: "demo",
    startPosition: stan:LAST_RECEIVED
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) {
        // Prints the incoming message in the console.
        string|error messageData = string:fromBytes(message.content);
        if messageData is string {
            log:printInfo("Message Received to service " +
            "receiveFromLastReceived: " + messageData);
        }
    }
}

[stan:SEQUENCE_NUMBER, int] sequenceNo = [stan:SEQUENCE_NUMBER, 3];
// Binds the consumer to listen to the messages published to the 'demo' subject.
// Receives messages starting from the provided sequence number.
@stan:ServiceConfig {
    subject: "demo",
    startPosition: sequenceNo
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) {
        // Prints the incoming message in the console.
        string|error messageData = string:fromBytes(message.content);
        if messageData is string {
            log:printInfo("Message Received to service receiveFromGivenIndex: "
                + messageData);
        }
    }
}

[stan:TIME_DELTA_START, int] timeDelta = [stan:TIME_DELTA_START, 5];
// Binds the consumer to listen to the messages published to the 'demo' subject.
// Receives messages since the provided historical time delta.
@stan:ServiceConfig {
    subject: "demo",
    startPosition: timeDelta
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) {
        // Prints the incoming message in the console.
        string|error messageData = string:fromBytes(message.content);
        if messageData is string {
            log:printInfo("Message Received to service receiveSinceTimeDelta: "
                + messageData);
        }
    }
}
