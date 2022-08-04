import ballerina/io;
import ballerinax/stan;

// Represents the escape character.
const string ESCAPE = "!q";

// Produces a message to a subject in the NATS Streaming sever.
public function main() returns error? {
    string message = "";
    stan:Client publisher = check new(stan:DEFAULT_URL);

    while (message != ESCAPE) {
        message = io:readln("Message: ");
        if message != ESCAPE {

            // Produces a message to the specified subject.
            string result = check publisher->publishMessage({
                                    content: message.toBytes(),
                                    subject: "demo"});
            io:println("GUID " + result +
                            " received for the produced message.");
        }
    }
}
