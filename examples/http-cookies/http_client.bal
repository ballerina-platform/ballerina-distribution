import ballerina/http;
import ballerina/log;

// HTTP client configurations associated with [enabling cookies](https://docs.central.ballerina.io/ballerina/http/latest/records/CookieConfig).
http:ClientConfiguration clientEPConfig = {
    cookieConfig: {
        enabled: true
    }
};

public function main() returns error? {
    // Create a new HTTP client by giving the URL and the client configuration.
    http:Client httpClient = check new("http://localhost:9095/cookieDemo",
                                  clientEPConfig);

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

    if (loginResp is error) {
        log:printError("Login failed", 'error = loginResp);
    } else {
        // When the login is successful, make another request to the
        // `/welcome` resource of the backend service.
        // As cookies are enabled in the HTTP client, it automatically handles cookies
        // received with the login response and sends the relevant cookies
        // to the `welcome` service resource.
        var welcomeResp = httpClient->get("/welcome", targetType = string);

        if (welcomeResp is string) {
            // A welcome message with the sent username
            // will get printed.
            log:printInfo(welcomeResp);
        }
    }
}
