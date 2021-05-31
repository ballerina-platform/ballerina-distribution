import ballerina/udp;
import ballerina/io;

// You can combine listener declaration into service declaration as shown in this exampe. 
service on new udp:Listener(8080) {
    remote function onDatagram(readonly & udp:Datagram dg) {
        io:println("bytes received: ", dg.data.length());
    }
}
