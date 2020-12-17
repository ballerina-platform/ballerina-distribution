import ballerina/io;
import ballerinax/stan;

// Produces a message to a subject in the NATS sever.
public function main() returns error? {
    string message = "Hello from Ballerina";
    stan:Client stanClient = new;
    // Produces a message to the specified subject.
    string|stan:Error result =
                    stanClient->publish("demo", <@untainted>message.toBytes());
    if (result is stan:Error) {
        io:println("Error occurred while producing the message.");
    } else {
        io:println("GUID " + result + " received for the produced message.");
    }
}
