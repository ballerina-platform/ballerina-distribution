import ballerina/io;
import ballerinax/nats;

public function main() returns error? {
    string message = "Hello from Ballerina";
    // Initializes a NATS client.
    nats:Client natsClient = check new(nats:DEFAULT_URL);

    // Sends a request and returns the reply.
    nats:Message reply = check natsClient->requestMessage({
                             content: message.toBytes(),
                             subject: "demo.bbe"});

    // Prints the reply message.
    string replyContent = check string:fromBytes(reply.content);
    io:println("Reply message: " + replyContent);

    // Closes the client connection.
    check natsClient.close();
}
