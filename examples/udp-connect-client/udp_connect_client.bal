// This is the connection oriented client implementation of the UDP socket.
import ballerina/io;
import ballerina/udp;

public function main() returns error? {
  
    // Create a new connection-oriented UDP client by providing the 
    // `remoteHost` and the `remotePort`.
    // Optionally, you can provide the interface that the socket needs to bind 
    // and the timeout in milliseconds, which specifies the read timeout value.
    // udp:Client client = new ("www.ballerina.com", 80,
    //                         localHost = "localhost", timeout = 5);
    udp:ConnectClient socketClient = check new("localhost", 8080);

    string msg = "Hello Ballerina echo";

    // Send data to the connected remote host.
    // The parameter is a byte[], which contains the data to be sent.
    check socketClient->writeBytes(msg.toBytes());
    io:println("Data was sent to the remote host.");

    // Wait until data is received from the connected host.
    readonly & byte[] result = check socketClient->readBytes();
    io:println("Received: ", string:fromBytes(result));

    // Close the client and release the bound port.
    check socketClient->close();
}
