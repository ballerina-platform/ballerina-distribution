import ballerina/tcp;
import ballerina/io;

public function main() returns error? {
    // The [secureSocket](https://docs.central.ballerina.io/ballerina/tcp/latest/records/ClientSecureSocket) record used to configure the client with TLS
    tcp:Client socketClient = check new ("localhost", 9002, secureSocket = {
        // Provide the trusted certificate path or the truststore path 
        // along with the truststore password.
        cert: "../resource/path/to/public.crt",
        protocol: {
            name: tcp:TLS,
            versions: ["TLSv1.2", "TLSv1.1"]
        },
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]
    });

    string msg = "Hello Ballerina Echo from secure client";
    byte[] msgByteArray = msg.toBytes();
    check socketClient->writeBytes(msgByteArray);

    readonly & byte[] receivedData = check socketClient->readBytes();
    io:print('string:fromBytes(receivedData));

    check socketClient->close();
}
