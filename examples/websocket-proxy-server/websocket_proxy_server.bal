import ballerina/http;
import ballerina/log;
import ballerina/websocket;

final string ASSOCIATED_CONNECTION = "ASSOCIATED_CONNECTION";
// The Url of the remote backend.
final string REMOTE_BACKEND = "ws://echo.websocket.org";

service /proxy/ws on new websocket:Listener(9090) {
    resource function get .(http:Request req) returns
                         websocket:Service|websocket:UpgradeError {
        return service object websocket:Service {
            websocket:AsyncClient? targetEp = ();
            // This resource gets invoked when a new client connects.
            // Since messages to the server are not read by the service until
            // the execution of the `onConnect` resource finishes, operations
            // which should happen before reading messages should be done
            // in the `onConnect` resource.
            remote function onConnect(websocket:Caller caller) returns
                            websocket:Error? {

                websocket:AsyncClient wsClientEp = check new (
                    REMOTE_BACKEND, service object websocket:Service {
                         //This resource gets invoked upon receiving a new
                         // text frame from the remote backend.
                        remote function onString(websocket:Caller caller,
                                        string text) {

                            websocket:Caller serverEp =
                                        getAssociatedServerEndpoint(caller);
                            var err = serverEp->writeString(text);
                            if (err is websocket:Error) {
                                log:printError(
                                    "Error occurred when sending text message", err = err);
                            }
                        }

                        //This resource gets invoked upon receiving a new
                        // binary frame from the remote backend.
                        remote function onBytes(websocket:Caller caller,
                                        byte[] data) {

                            websocket:Caller serverEp =
                                        getAssociatedServerEndpoint(caller);
                            var err = serverEp->writeBytes(data);
                            if (err is websocket:Error) {
                                log:printError(
                                    "Error occurred when sending binary message",
                                    err = err);
                            }
                        }

                        //This resource gets invoked when an error
                        // occurs in the connection.
                        remote function onError(websocket:Caller caller,
                                        error err) {

                            websocket:Caller serverEp =
                                        getAssociatedServerEndpoint(caller);
                            var e = serverEp->close(statusCode = 1011,
                                            reason = "Unexpected condition");
                            if (e is websocket:Error) {
                                log:printError(
                                    "Error occurred when closing the connection",
                                    err = e);
                            }
                            _ = caller.removeAttribute(ASSOCIATED_CONNECTION);
                            log:printError(
                                "Unexpected error hense closing the connection",
                                err = err);
                        }

                        //This resource gets invoked when a client connection
                        // is closed by the remote backend.
                        remote function onClose(websocket:Caller caller,
                                        int statusCode, string reason) {

                            websocket:Caller serverEp =
                                        getAssociatedServerEndpoint(caller);
                            var err = serverEp->close(statusCode = statusCode,
                                       reason = reason);
                            if (err is websocket:Error) {
                                log:printError(
                                    "Error occurred when closing the connection",
                                    err = err);
                            }
                            _ = caller.removeAttribute(ASSOCIATED_CONNECTION);
                        }
                    },
                    {
                        // When creating client endpoint, if `readyOnConnect`
                        // flag is set to `false` client endpoint does not
                        // start reading frames automatically.
                        readyOnConnect: false
                    }
                );
                //Associate connections before starting to read messages.
                self.targetEp = wsClientEp;
                wsClientEp.setAttribute(ASSOCIATED_CONNECTION, caller);

                // Once the client is ready to receive frames, the remote function [ready](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/websocket/clients/WebSocketClient#ready)
                // of the client need to be called separately.
                var err = wsClientEp->ready();
                if (err is websocket:Error) {
                    log:printError("Error calling ready on client", err = err);
                }
            }

            //This resource gets invoked upon receiving a new text frame
            // from a client.
            remote function onString(websocket:Caller caller, string text) {
                websocket:AsyncClient clientEp =
                        <websocket:AsyncClient>self.targetEp;
                var err = clientEp->writeString(text);
                if (err is websocket:Error) {
                    log:printError("Error occurred when sending text message",
                             err = err);
                }
            }

            //This resource gets invoked upon receiving a new binary
            // frame from a client.
            remote function onBinary(websocket:Caller caller, byte[] data) {
                websocket:AsyncClient clientEp =
                        <websocket:AsyncClient>self.targetEp;
                var err = clientEp->writeBytes(data);
                if (err is websocket:Error) {
                    log:printError(
                        "Error occurred when sending binary message",
                        err = err);
                }
            }

            //This resource gets invoked when an error occurs
            // in the connection.
            remote function onError(websocket:Caller caller, error err) {
                websocket:AsyncClient clientEp =
                         <websocket:AsyncClient>self.targetEp;
                var e = clientEp->close(statusCode = 1011,
                                reason = "Unexpected condition");
                if (e is websocket:Error) {
                    log:printError(
                        "Error occurred when closing the connection",
                        err = e);
                }
                _ = caller.removeAttribute(ASSOCIATED_CONNECTION);
                log:printError(
                    "Unexpected error hence closing the connection",
                    err = err);
            }

            //This resource gets invoked when a client connection is closed
            // from the client side.
            remote function onClose(websocket:Caller caller, int statusCode,
                                        string reason) {
                websocket:AsyncClient clientEp =
                         <websocket:AsyncClient>self.targetEp;
                var err = clientEp->close(statusCode = statusCode,
                           reason = reason);
                if (err is websocket:Error) {
                    log:printError(
                        "Error occurred when closing the connection",
                        err = err);
                }
                _ = caller.removeAttribute(ASSOCIATED_CONNECTION);
            }
        };
    }
}

//Client service to receive frames from the remote server.
service class ClientService {
    *websocket:Service;
    //This resource gets invoked upon receiving a new text frame from
    // the remote backend.
    remote function onString(websocket:Caller caller, string text) {

        websocket:Caller serverEp =
                        getAssociatedServerEndpoint(caller);
        var err = serverEp->writeString(text);
        if (err is websocket:Error) {
            log:printError("Error occurred when sending text message",
                err = err);
        }
    }

    //This resource gets invoked upon receiving a new binary frame from
    // the remote backend.
    remote function onBytes(websocket:Caller caller, byte[] data) {

        websocket:Caller serverEp =
                        getAssociatedServerEndpoint(caller);
        var err = serverEp->writeBytes(data);
        if (err is websocket:Error) {
            log:printError("Error occurred when sending binary message",
                err = err);
        }
    }

    //This resource gets invoked when an error occurs in the connection.
    remote function onError(websocket:Caller caller, error err) {

        websocket:Caller serverEp =
                        getAssociatedServerEndpoint(caller);
        var e = serverEp->close(statusCode = 1011,
                        reason = "Unexpected condition");
        if (e is websocket:Error) {
            log:printError("Error occurred when closing the connection",
                            err = e);
        }
        _ = caller.removeAttribute(ASSOCIATED_CONNECTION);
        log:printError("Unexpected error hense closing the connection",
            err = err);
    }

    //This resource gets invoked when a client connection is closed by
    // the remote backend.
    remote function onClose(websocket:Caller caller, int statusCode,
                                string reason) {

        websocket:Caller serverEp =
                        getAssociatedServerEndpoint(caller);
        var err = serverEp->close(statusCode = statusCode, reason = reason);
        if (err is websocket:Error) {
            log:printError("Error occurred when closing the connection",
                err = err);
        }
        _ = caller.removeAttribute(ASSOCIATED_CONNECTION);
    }
}

// Function to retrieve the associated caller for a client.
function getAssociatedServerEndpoint(websocket:Caller ep)
                                        returns (websocket:Caller) {
    websocket:Caller wsEndpoint =
            <websocket:Caller>ep.getAttribute(ASSOCIATED_CONNECTION);
    return wsEndpoint;
}
