import ballerina/io;
import ballerina/udp;

// You can combine a listener declaration with a service declaration as shown in this example.
service on new udp:Listener(8080) {
    remote function onDatagram(readonly & udp:Datagram dg) {
        io:println("bytes received: ", dg.data.length());
    }
}
