// This is the server implementation for the UDP socket.
import ballerina/io;
import ballerina/udp;
import ballerina/log;

// Bind the service to the port.
// Optionally, you can provide remoteHost and remotePort to
// configure the listener  as a connected listener which only
// read and write to the configured remote host.
// udp:Listener(48829, remoteHost = "www.remote-clinet.com", remotePort = 8080)
service on new udp:Listener(48829) {

    // This remote is invoked once the content is received from the client.
    // you may replace the onBytes method with onDatagram which reads the data as
    // readonly & udp:Datagram.
    remote function onBytes(readonly & byte[] data, udp:Caller caller) 
            returns (readonly & byte[])|udp:Error? {
        io:println("Received by listener:", getString(data));
        // Echo back the data to the same client
        // this is similar to calling caller->sendBytes(data);
        return data;
    }

    // This remote is invoked for the error situation
    // if it happens during the `onBytes` and `onDatagram`.
    remote function onError(readonly & udp:Error err) {
        log:printError(msg = err.message());
    }
}

function getString(byte[] content) returns @tainted string|io:Error {
    io:ReadableByteChannel byteChannel = check io:createReadableChannel(content);
    io:ReadableCharacterChannel characterChannel = new io:ReadableCharacterChannel(byteChannel, "UTF-8");
    return check characterChannel.read(content.length());
}