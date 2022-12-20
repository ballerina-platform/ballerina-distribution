import ballerina/io;
import ballerina/tcp;

// An HTTP listener can be configured to communicate through SSL/TLS as well.
// To secure a listener using SSL/TLS, the listener needs to be configured with
// a certificate file and a private key file for the listener.
// The `tcp:ListenerSecureSocket` record provides the
// SSL-related listener configurations of the listener.
listener tcp:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

service "tcp" on securedEP {
     remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService {
        io:println("Client connected on server port: ", caller.remotePort);
        return new EchoService();
    }
}

service class EchoService {
    *tcp:ConnectionService;

    remote function onBytes(readonly & byte[] data) returns byte[] {
        io:println("Received message: ", string:fromBytes(data));
        return data;
    }
}
