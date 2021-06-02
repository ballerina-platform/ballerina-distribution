import ballerina/io;
import ballerinax/stan;

// Produces a message to a subject in the NATS sever.
public function main() returns error? {
    string message = "Hello from Ballerina";
    stan:Client stanClient = check new(stan:DEFAULT_URL);

    // Produces a message to the specified subject.
    string result = check stanClient->publishMessage({
                                    content: message.toBytes(),
                                    subject: "demo"});
    io:println("GUID " + result + " received for the produced message.");
    // Closes the client connection.
    check stanClient.close();
}
