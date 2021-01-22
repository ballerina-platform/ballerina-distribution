import ballerina/http;
import ballerina/io;
import ballerina/log;

@http:ServiceConfig {
    basePath: "/cookie-demo"
}
service cookieServer on new http:Listener(9095) {

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/login"
    }
    resource function login(http:Caller caller, http:Request req) {

        // Retrieve the JSON payload from the request as it
        // contains the login details of a user.
        json|error details = req.getJsonPayload();
        if (details is json) {

            // Retrieve the username and password.
            json|error name = details.name;
            json|error password = details.password;

            if (name is json && password is json) {
                // Check the password value.
                if (password == "p@ssw0rd") {

                    // [Create a new cookie](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/http/latest/http/classes/Cookie) by setting the `name` as the `username`
                    // and `value` as the logged-in user's name.
                    http:Cookie cookie = new("username", name.toString());

                    // Set the cookie's path as `/` to apply it to all the
                    // resources in the service.
                    cookie.path = "/";

                    // [Add the created cookie to the response](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/http/latest/http/classes/Response#addCookie).
                    http:Response response = new;
                    response.addCookie(cookie);

                    // Set a message payload to inform that the login has
                    // been succeeded.
                    response.setTextPayload("Login succeeded");
                    var result = caller->respond(response);
                    if (result is error) {
                        log:printError("Failed to respond", result);
                    }
                }
            }
        }
    }

    // Upgrade from HTTP to WebSocket and define the service the WebSocket client needs to connect to.
    @http:ResourceConfig {
        webSocketUpgrade: {
            upgradePath: "/ws",
            upgradeService: cookieService
        }
    }
    resource function upgrader(http:Caller caller, http:Request req) {

        // [Retrieve cookies from the request](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/http/latest/http/classes/Request#getCookies).
        http:Cookie[] cookies = req.getCookies();

        // Get the cookie value of the `username`.
        http:Cookie[] usernameCookie = cookies.filter(function
                                (http:Cookie cookie) returns boolean {
            return cookie.name == "username";
        });
        if (usernameCookie.length() > 0) {
            string? user = usernameCookie[0].value;
            if (user is string) {
                log:printInfo("WebSocket connection made successfully");
            } else {
                // If the user is `nil`, cancel the upgrade WebSocket connection.
                var result = caller->cancelWebSocketUpgrade(401,
                                     "Unauthorized request. Please login");
                if (result is error) {
                    log:printError("Failed to cancel the WebSocket upgrade",
                                    result);
                }
            }
        } else {
            // If the `username` cookie is not presented, cancel the upgrade
            // WebSocket connection.
            var result = caller->cancelWebSocketUpgrade(401,
                                 "Unauthorized request. Please login");
            if (result is error) {
                log:printError("Failed to cancel the WebSocket upgrade",
                                result);
            }
        }
    }
}

// The callback service to receive frames from the client.
service cookieService =
        @http:WebSocketServiceConfig {subProtocols: ["xml", "json"]} service {

    // This resource gets invoked when a new client connects.
    resource function onOpen(http:WebSocketCaller caller) {
        io:println("New WebSocket connection: " + caller.getConnectionId());
    }

    //This resource gets invoked upon receiving a new text frame from a client.
    resource function onText(http:WebSocketCaller caller, string text) {
        io:println(text);
        var err = caller->pushText(text);
        if (err is error) {
            log:printError("Error sending message", err);
        }
    }

    //This resource gets invoked when an error occurs in the connection.
    resource function onError(http:WebSocketCaller caller, error err) {
        log:printError("Error occurred ", err);
    }
};
