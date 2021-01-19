// This is the connectionless client implementation for the UDP socket.
import ballerina/io;
import ballerina/udp;

public function main() returns error? {
  
    // Create a new connectionless UDP client.
    // Optionally, you can provide the interface that the socket needs to bind 
    // and the timeout in milliseconds, which specifies the read timeout value.
    // udp:Client client = new (localHost = "localhost", timeoutInMillis = 2000);
    udp:Client socketClient = check new;
   

    string msg = "Hello Ballerina echo";
    udp:Datagram datagram = {
        remoteHost: "localhost",
        remotePort : 48829,
        data : msg.toBytes()
    };

    // Send the data to remote host.
    // The parameter is a Datagram record, which contains the `remoteHost`, `remotePort`,
    // and the `data` to be sent.
    var sendResult = socketClient->sendDatagram(datagram);
    if (sendResult is ()) {
        io:println("Datagram was sent to the remote host.");
    } else {
        error e = sendResult;
        panic e;
    }
    
    // Wait until data is received from the remote host.
    var result = socketClient->receiveDatagram();
    if (result is (readonly & udp:Datagram)) {

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
