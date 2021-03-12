import ballerina/tcp;
import ballerina/io;

// An tcp listener can be configured to communicate through SSL/TLS as well.
// [secureSocket](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/tcp/latest/tcp/records/ListenerSecureSocket) record provides the SSL related configurations.
// which will configure a listener to accept new connections that
// are secured via SSL.
service on new tcp:Listener(9090, secureSocket = {
    // Provide the server certificate path and the privateKey path 
    // keystore path along with keystore password.
    key: {
        certFile: "../resource/path/to/public.crt",
        keyFile: "../resource/path/to/private.key"
    },
    // Enable the preferred SSL protocol and its versions.
    protocol: {
        name: tcp:TLS,
        versions: ["TLSv1.2", "TLSv1.1"]
    },
    // Configure the preferred ciphers.
    ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]
}) {

    isolated remote function onConnect(tcp:Caller caller) 
        returns tcp:ConnectionService {
        io:println("Client connected to server: ", caller.remotePort);
        return new EchoService();
    }
}

service class EchoService {

    remote function onBytes(readonly & byte[] data) returns readonly & byte[] {
        io:println("Received: ", 'string:fromBytes(data));
        return data;
    }
}
