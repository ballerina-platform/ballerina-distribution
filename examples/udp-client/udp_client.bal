import ballerina/io;
import ballerina/udp;

public function main() returns error? {
    // Creates a new connectionless UDP client.
    // Optionally, you can provide the address that the socket needs to bind
    // and the timeout in seconds, which specifies the read timeout value.
    // E.g.: `udp:Client client = new (localHost = "localhost", timeout = 5);`
    udp:Client socketClient = check new;

    udp:Datagram datagram = {
        remoteHost: "localhost",
        remotePort: 9090,
        data: "Hello Ballerina echo".toBytes()
    };

    // Sends the data to the remote host.
    // The parameter is a Datagram record, which contains the `remoteHost`,
    // `remotePort`, and the `data` to be sent.
    check socketClient->sendDatagram(datagram);
    io:println("Datagram was sent to the remote host.");

    // Waits until the data is received from the remote host.
    readonly & udp:Datagram result = check socketClient->receiveDatagram();
    io:println("Received: ", string:fromBytes(result.data));

    // Closes the client and releases the bound port.
    check socketClient->close();
}
