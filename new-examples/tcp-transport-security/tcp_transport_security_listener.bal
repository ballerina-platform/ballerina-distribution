import ballerina/tcp;
import ballerina/io;

// A TCP listener can be configured to communicate through SSL/TLS as well.
// The [secureSocket](https://docs.central.ballerina.io/ballerina/tcp/latest/records/ListenerSecureSocket) record provides the SSL related configurations,
// which will configure a listener to accept new connections that
// are secured via SSL.
tcp:ListenerSecureSocket listenerSecureSocket = {
    // Provide the server certificate path and the private key path 
    // or the keystore path along with keystore password.
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
};

service on new tcp:Listener(9002, secureSocket = listenerSecureSocket) {

    isolated remote function onConnect(tcp:Caller caller) 
        returns tcp:ConnectionService {
        io:println("Client connected to server: ", caller.remotePort);
        return new EchoService();
    }
}

service class EchoService {

    remote function onBytes(readonly & byte[] data) returns byte[] {
        io:println("Received: ", 'string:fromBytes(data));
        return data;
    }
}
