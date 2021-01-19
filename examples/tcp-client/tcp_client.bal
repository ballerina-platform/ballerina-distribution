// This is the client implementation for the TCP socket.
import ballerina/io;
import ballerina/tcp;

public function main() returns error? {

    // Create a new TCP client by providing the `remoteHost` and `remotePort`.
    // Optionally, you can provide the interface that the socket needs to bind 
    // and the timeout in milliseconds, which specifies the read timeout value.
    // tcp:Client client = check new ("localhost", 3000, localHost = "localhost",
    //                             timeoutInMillis = 2000);
    tcp:Client socketClient = check new ("localhost", 3000);

    // Send the desired content to the server.
    string msg = "Hello Ballerina Echo from client";
    byte[] msgByteArray = msg.toBytes();
    check  socketClient->writeBytes(msgByteArray);

    // Reading the response from the server.
    readonly & byte[] receivedData = check socketClient->readBytes();

    io:ReadableByteChannel byteChannel = check io:createReadableChannel(receivedData);
    io:ReadableCharacterChannel characterChannel = new io:ReadableCharacterChannel(byteChannel, "UTF-8");
    string stringData = check characterChannel.read(receivedData.length());
    io:println("Recived: ", stringData);

    // Close the connection between the server and the client.
    var closeResult = socketClient->close();
    if (closeResult is error) {
        io:println("An error occurred while closing the socket ", closeResult);
    }
}

