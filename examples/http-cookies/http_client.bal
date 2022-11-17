import ballerina/http;
import ballerina/log;

// HTTP client configurations associated with enabling cookies.
// For details, see https://lib.ballerina.io/ballerina/http/latest/records/CookieConfig.
http:ClientConfiguration clientEPConfig = {
    cookieConfig: {
        enabled: true
    }
};

public function main() returns error? {
    // Create a new HTTP client by giving the URL and the client configuration.
    http:Client httpClient = check new("http://localhost:9095/cookieDemo", clientEPConfig);

    // Send a username and password as a JSON payload to the backend.
    json payload = {
        name: "John",
        password: "p@ssw0rd"
    };

    // Send an outbound request to the `login` backend resource.
    http:Response loginResp = check httpClient->post("/login", payload);

    if loginResp.statusCode != 200 {
        log:printError("Login failed");
    } else {
        // When the login is successful, make another request to the
        // `/welcome` resource of the backend service.
        // As cookies are enabled in the HTTP client, it automatically handles cookies
        // received with the login response and sends the relevant cookies
        // to the `welcome` service resource.
        string welcomeResp = check httpClient->get("/welcome");

        // A welcome message with the sent username will get printed.
        log:printInfo(welcomeResp);
    }
}
