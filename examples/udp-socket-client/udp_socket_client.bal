// This is the connectionless client implementation for the UDP socket.
import ballerina/io;
import ballerina/udp;

public function main() {
  
    // Create a new connectionless udp client.
    // Optionally, you can provide interface that the socket need to bind 
    // and the timeout in milliseconds which specifies the read timeout value
    // udp:Client client = new ("localhost", 2000);
    udp:Client socketClient = checkpanic new ;
   

    string msg = "Hello Ballerina echo";
    tcp:Datagram datagram = {
        remoteAddress : {
            host : "localhost",
            port : 48829
        },
        data : msg.toBytes()
    };

    // Send data to remote host.
    // The parameter is a Datagram record which contains the remote address
    // and the data to be.
    var sendResult = socketClient->send(datagram);
    if (sendResult is ()) {
        io:println("Datagram was sent to the remote host.");
    } else {
        error e = sendResult;
        panic e;
    }
    
    // Wait until data receive from remote host.
    var result = socketClient->receive();
    if (result is tcp:Datagram) {

        var byteChannel = io:createReadableChannel(result.data);
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
