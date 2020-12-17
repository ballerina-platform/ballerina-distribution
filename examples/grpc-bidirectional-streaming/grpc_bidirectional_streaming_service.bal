// This is the server implementation for the bidirectional streaming scenario.
import ballerina/grpc;
import ballerina/log;

map<grpc:Caller> consMap = {};

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service /Chat on new grpc:Listener(9090) {

    remote function chat(grpc:Caller caller,
                                stream<ChatMessage, error> clientStream) {
        log:print(string `${caller.getId()} connected to chat`);
        consMap[caller.getId().toString()] = <@untainted>caller;
        //Read and process each message in the client stream
        error? e = clientStream.forEach(function(ChatMessage chatMsg) {
            grpc:Caller ep;
            string msg = string `${chatMsg.name}: ${chatMsg.message}`;
            log:print("Server received message: " + msg);
            foreach var [callerId, connection] in consMap.entries() {
                ep = connection;
                grpc:Error? err = ep->send(msg);
                if (err is grpc:Error) {
                    log:printError("Error from Connector: " + err.message());
                } else {
                    log:print("Server message to caller " + callerId
                                                    + " sent successfully.");
                }
            }
        });
        //Once the client sends a notification to indicate the end of the stream, 'grpc:EOS' is returned by the stream
        if (e is grpc:EOS) {
            string msg = string `${caller.getId()} left the chat`;
            log:print(msg);
            var v = consMap.remove(caller.getId().toString());
            foreach var [callerId, connection] in consMap.entries() {
                grpc:Caller ep = connection;
                grpc:Error? err = ep->send(msg);
                if (err is grpc:Error) {
                    log:printError("Error from Connector: " + err.message());
                } else {
                    log:print("Server message to caller " + callerId
                                                    + " sent successfully.");
                }
            }
        //If the client sends an error to the server, the stream closes and returns the error
        } else if (e is error) {
            log:printError("Error from Connector: " + e.message());
        }

    }
}
