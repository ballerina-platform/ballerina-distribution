import ballerina/io;
import ballerina/udp;

// Binds the service to the port.
// Optionally, you can provide the `remoteHost` and `remotePort` to configure the listener
// as a connected listener, which only reads and writes to the configured remote host.
// E.g.: `udp:Listener(8080, remoteHost = "www.remote-clinet.com", remotePort = 9090)`
service on new udp:Listener(9090) {

    // This remote method is invoked once the content is received from the
    // client. You may replace the `onBytes` method with `onDatagram`, which
    // reads the data as `readonly & udp:Datagram`.
    remote function onDatagram(readonly & udp:Datagram datagram) returns udp:Datagram {
        io:println("Received by listener: ", string:fromBytes(datagram.data));
        // Echoes back the data to the same client.
        // This is similar to calling `caller->sendDatagram(datagram);`.
        return datagram;
    }
}
