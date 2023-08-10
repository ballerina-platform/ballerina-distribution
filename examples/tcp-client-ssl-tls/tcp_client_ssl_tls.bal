import ballerina/tcp;

public function main() returns error? {
    // A TCP client can be configured to communicate through SSL/TLS as well.
    // To secure a client using SSL/TLS, the client needs to be configured with
    // a certificate file of the listener.
    // The `tcp:ClientSecureSocket` record provides the
    // SSL-related configurations of the client.
    tcp:Client securedClientEP = check new ("localhost", 9090,
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    check securedClientEP->writeBytes("Hello, World!".toBytes());
    check securedClientEP->close();
}
