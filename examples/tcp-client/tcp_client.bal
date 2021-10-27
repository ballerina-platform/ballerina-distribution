import ballerina/io;
import ballerina/tcp;

public function main() returns error? {

    // Create a new TCP client by providing the `remoteHost` and `remotePort`.
    // Optionally, you can provide the interface that the socket needs to bind 
    // and the timeout in seconds, which specifies the read timeout value.
    // tcp:Client client = check new ("localhost", 3000, localHost = "localhost",
    //                             timeout = 5);
    tcp:Client socketClient = check new ("localhost", 3000);

    // Send the desired content to the server.
    string msg = "Hello Ballerina Echo from client";
    byte[] msgByteArray = msg.toBytes();
    check socketClient->writeBytes(msgByteArray);

    // Read the response from the server.
    readonly & byte[] receivedData = check socketClient->readBytes();
    io:println("Received: ", string:fromBytes(receivedData));

    // Close the connection between the server and the client.
    return socketClient->close();
}
