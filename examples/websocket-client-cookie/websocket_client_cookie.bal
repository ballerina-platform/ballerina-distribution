import ballerina/http;
import ballerina/io;
import ballerina/log;

// HTTP client configurations associated with [enabling cookies](https://ballerina.io/swan-lake/learn/api-docs/ballerina/http/records/CookieConfig.html).
http:ClientConfiguration clientEPConfig = {
    cookieConfig: {
        enabled: true
    }
};

public function main() {
    // Create a new HTTP client by giving the URL and the client configuration.
    http:Client httpClient = new("http://localhost:9095/cookie-demo", clientEPConfig);

    // Initialize an HTTP request.
    http:Request request = new;

    // Send a username and a password as a JSON payload to the backend.
    json jsonPart = {
        name: "John",
        password: "p@ssw0rd"
    };
    request.setJsonPayload(jsonPart);

    // Send an outbound request to the `login` backend resource.
    var loginResp = httpClient->post("/login", request);

    if (loginResp is http:Response) {
            // This response contains the cookies added by the backend server.
            // Get the login response message.
            string|error loginMessage = loginResp.getTextPayload();

            if (loginMessage is error) {
                io:println("Login failed", loginMessage);
            } else {
                // When the login is successful, extract the name and value
                // from the response
                http:Cookie[] cookies = loginResp.getCookies();
                map<string> wsCookies = {};
                foreach var cookie in cookies {
                    var cookieName = cookie.name;
                    var cookieValue = cookie.value;
                    if (cookieName is string && cookieValue is string) {
                        wsCookies[cookieName] = cookieValue;
                    }
                }

                // Initialize the WebSocket client with cookies' name and value
                http:WebSocketClient wsClientEp = new ("ws://localhost:9095/cookie-demo/ws",
                                config = {callbackService: ClientService, cookies: wsCookies});

                // Pushes text to the connection
                var err = wsClientEp->pushText("Hello World!");
                if (err is error) {
                    io:println(err);
                }
            }
        } else {
            log:printError(loginResp.message());
        }
}

// Client service to receive frames from the remote server.
service ClientService = @http:WebSocketServiceConfig {} service {

    // This resource gets invoked upon receiving a new text frame from the remote backend.
    resource function onText(http:WebSocketClient conn, string text, boolean finalFrame) {
        io:println(text);
    }

     // This resource gets invoked when an error occurs in the connection.
    resource function onError(http:WebSocketClient conn, error err) {
        io:println(err);
    }
};