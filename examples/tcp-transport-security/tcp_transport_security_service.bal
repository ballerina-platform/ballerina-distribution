import ballerina/io;
import ballerina/tcp;

// An HTTP listener can be configured to communicate through SSL/TLS as well.
// To secure an listener using SSL/TLS, the listener needs to be configured with
// a certificate file and a private key file for the listener.
// The [`tcp:ListenerSecureSocket`](https://docs.central.ballerina.io/ballerina/tcp/latest/records/ListenerSecureSocket) record
// provides the SSL-related listener configurations of the listener.
listener tcp:Listener securedEP = check new(3000,
    secureSocket = {
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
    }
);

service "tcp" on securedEP {
    isolated remote function onConnect(tcp:Caller caller)
                             returns tcp:ConnectionService {
        io:println("Client connected on server port: ", caller.remotePort);
        return new EchoService();
    }
}

service class EchoService {
    remote function onBytes(readonly & byte[] data) returns byte[] {
        io:println("Received message: ", string:fromBytes(data));
        return data;
    }
}
