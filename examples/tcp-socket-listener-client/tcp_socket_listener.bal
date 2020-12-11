// This is the server implementation for the TCP socket.
import ballerina/io;
import ballerina/log;
import ballerina/tcp;

// Bind the service to the port.
// The tcp listener should have these four predefined resources.
service "echoServer" on new tcp:Listener(61598) {
    // This remote is invoked when the new client joins.
    remote function onConnect(tcp:Caller caller) {
        log:printInfo("Client connected: " + caller.id.toString());
    }

    // This remote is invoked once the content is received from the client.
    remote function onReadReady(tcp:Caller caller) {
        var result = caller->read();
        if (result is [byte[], int]) {
            var [content, length] = result;
            if (length > 0) {
                // Create a new `ReadableByteChannel` using the newly received content.
                var byteChannel =
                io:createReadableChannel(content);
                if (byteChannel is io:ReadableByteChannel) {
                    io:ReadableCharacterChannel characterChannel =
                    new io:ReadableCharacterChannel(byteChannel, "UTF-8");
                    var str = characterChannel.read(20);
                    if (str is string) {
                        string reply = <@untainted>str + " back";
                        byte[] payloadByte = reply.toBytes();
                        // Send the reply to the `caller`.
                        int i = 0;
                        int arrayLength = payloadByte.length();
                        while (i < arrayLength) {
                            var writeResult = caller->write(payloadByte);
                            if (writeResult is int) {
                                log:printInfo("Number of bytes written: "
                                    + writeResult.toString());
                                i = i + writeResult;
                                payloadByte = payloadByte.slice(writeResult,
                                                                arrayLength);
                            } else {
                                log:printError("Unable to write the content",
                                    writeResult);
                            }
                        }
                    } else {
                        log:printError("Error while writing content to " +
                                        "the caller", str);
                    }
                }
            } else {
                log:printInfo("Client left: " + caller.id.toString());
            }
        } else {
            io:println(result);
        }
    }

    // This remote is invoked for the error situation
    // if it happens during the `onConnect` and `onReadReady`.
    remote function onError(tcp:Caller caller, error er) {
        log:printError("An error occurred", er);
    }
}
