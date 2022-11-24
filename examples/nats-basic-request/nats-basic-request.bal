import ballerina/io;
import ballerinax/nats;

public function main() returns error? {
    // Initializes a NATS client.
    nats:Client natsClient = check new (nats:DEFAULT_URL);

    // Sends a request and returns the reply.
    StringMessage reply = check natsClient->requestMessage({
        content: "Hello from Ballerina",
        subject: "demo.bbe"
    });
    // Prints the reply message.
    io:println("Reply message: " + reply.content);

    // Closes the client connection.
    check natsClient.close();
}

public type StringMessage record {|
    *nats:AnydataMessage;
    string content;
|};
