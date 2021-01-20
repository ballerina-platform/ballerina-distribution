import ballerina/io;
import ballerinax/stan;

// Represents the escape character.
const string ESCAPE = "!q";

// Produces a message to a subject in the NATS Streaming sever.
public function main() returns error? {
    string message = "";
    stan:Client publisher = check new;

    while (message != ESCAPE) {
        message = io:readln("Message: ");
        if (message != ESCAPE) {
            // Produces a message to the specified subject.
            string|stan:Error result =
                            publisher->publishMessage({
                                content: <@untainted>message.toBytes(),
                                subject: "demo"});
            if (result is stan:Error) {
                io:println("Error occurred while producing the message.");
            } else {
                io:println("GUID " + result +
                            " received for the produced message.");
            }
        }
    }
}
