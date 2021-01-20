// This is the connection oriented client implementation for the UDP socket.
import ballerina/io;
import ballerina/udp;

public function main() returns error? {
  
    // Create a new connection oriented udp client by providing the 
    // remoteHost and the remotePort.
    // Optionally, you can provide interface that the socket need to bind 
    // and the timeout in milliseconds which specifies the read timeout value
    // udp:Client client = new ("www.ballerina.com", 80,
    //                         localHost = "localhost", timeoutInMillis = 2000);
    udp:ConnectClient socketClient = check new("www.ballerina.com", 80);
   
    string msg = "Hello Ballerina echo";

    // Send data to the connected remote host.
    // The parameter is a byte[] which contains the data to be.
    var sendResult = socketClient->writeBytes(msg.toBytes());
    if (sendResult is ()) {
        io:println("Data was sent to the remote host.");
    } else {
        error e = sendResult;
        panic e;
    }
    
    // Wait until data receive from the connected host.
    var result = socketClient->readBytes();
    if (result is (readonly & byte[])) {

        var byteChannel = io:createReadableChannel(result);
        if (byteChannel is io:ReadableByteChannel) {
            io:ReadableCharacterChannel characterChannel =
                new io:ReadableCharacterChannel(byteChannel, "UTF-8");
            var str = characterChannel.read(60);
            if (str is string) {
                io:println("Received: ", <@untainted>str);
            } else {
                io:println("Error: ", str.message());
            }
        }
    } else {
        io:println("An error occurred while receiving the data ",
            result);
    }

    // Close the client and release the bound port.
    var closeResult = socketClient->close();
    if (closeResult is error) {
        io:println("An error occurred while closing the socket ",
            closeResult);
    }
}
