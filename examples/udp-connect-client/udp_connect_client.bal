// This is the connection oriented client implementation of the UDP socket.
import ballerina/io;
import ballerina/udp;

public function main() returns error? {
  
    // Creates a new connection-oriented UDP client by providing the
    // `remoteHost` and the `remotePort`.
    // Optionally, you can provide the interface that the socket needs to bind 
    // and the timeout in milliseconds, which specifies the read timeout value.
    // E.g.: `udp:Client client = new ("www.ballerina.com", 80,
    // localHost = "localhost", timeout = 5);`
    udp:ConnectClient socketClient = check new("localhost", 8080);

    string msg = "Hello Ballerina echo";

    // Sends the data to the connected remote host.
    // The parameter is a `byte[]`, which contains the data to be sent.
    check socketClient->writeBytes(msg.toBytes());
    io:println("Data was sent to the remote host.");

    // Waits until the data is received from the connected host.
    readonly & byte[] result = check socketClient->readBytes();
    io:println("Received: ", string:fromBytes(result));

    // Closes the client and releases the bound port.
    check socketClient->close();

}
