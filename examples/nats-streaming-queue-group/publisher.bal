import ballerina/io;
import ballerinax/nats;

// Represents the escape character.
const string ESCAPE = "!q";

// Produces a message to a subject in the NATS sever.
public function main() returns error? {
    string message = "";
    nats:Connection conn = new;
    nats:StreamingProducer publisher = new (conn);

    while (message != ESCAPE) {
        message = io:readln("Message: ");
        if (message != ESCAPE) {
            // Produces a message to the specified subject.
            string|nats:Error result = publisher->publish("demo", <@untainted>message);
            if (result is nats:Error) {
                io:println("Error occurred while producing the message.");
            } else {
                io:println("GUID " + result + " received for the produced message.");
            }
        }
    }

    // Closes the connection.
    check conn.close();
}
