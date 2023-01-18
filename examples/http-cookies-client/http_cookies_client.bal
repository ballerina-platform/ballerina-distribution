import ballerina/http;
import ballerina/log;

// HTTP client configurations associated with enabling cookies.
http:ClientConfiguration clientEPConfig = {
    cookieConfig: {
        enabled: true
    }
};

public function main() returns error? {
    // Create a new HTTP client by giving the URL and the client configuration.
    http:Client httpClient = check new("localhost:9095/cookieDemo", clientEPConfig);

    // Send an outbound request to the `login` backend resource with username and password.
    string loginResp = check httpClient->post("/login", {
        name: "John",
        password: "p@ssw0rd"
    });
    log:printInfo(loginResp);

    // Make another request to the `/welcome` resource of the backend service.
    // As cookies are enabled in the HTTP client, it automatically handles cookies received with the
    // login response and sends the relevant cookies to the `welcome` service resource.
    string welcomeResp = check httpClient->get("/welcome");
    log:printInfo(welcomeResp);
}
