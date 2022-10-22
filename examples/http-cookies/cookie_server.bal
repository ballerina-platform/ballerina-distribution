import ballerina/http;

listener http:Listener serverEP = new (9095);

service /cookieDemo on serverEP {

    resource function post login(@http:Payload json details) returns http:Response|http:Unauthorized|error {

        // Retrieve the username and password.
        json name = check details.name;
        json password = check details.password;

        // Check the password value.
        if password == "p@ssw0rd" {

            // Create a new cookie by setting `name` as the `username` and `value` as the logged-in user's name.
            // Set the cookies path as `/` to apply it to all the resources in the service.
            // For details, see https://lib.ballerina.io/ballerina/http/latest/classes/Cookie.
            http:Cookie cookie = new("username", name.toString(), path = "/");
            http:Response response = new;

            // Add the created cookie to the response.
            // For details, see https://lib.ballerina.io/ballerina/http/latest/classes/Response#addCookie.
            response.addCookie(cookie);

            // Set a message payload to inform that the login has
            // been succeeded.
            response.setTextPayload("Login succeeded");
            return response;
        }
        return http:UNAUTHORIZED;
    }

    resource function get welcome(http:Request req) returns string {
        // Retrieve cookies from the request.
        // For details, see https://lib.ballerina.io/ballerina/http/latest/classes/Request#getCookies.
        http:Cookie[] cookies = req.getCookies();

        // Get the cookie value of the `username`.
        http:Cookie[] usernameCookie = cookies.filter(function(http:Cookie cookie) returns boolean {
            return cookie.name == "username";
        });

        if usernameCookie.length() > 0 {
            string? user = usernameCookie[0].value;
            if user is string {
                // Respond with the username added to the welcome message.
                return "Welcome back " + user;

            }
            // If the user is `nil`, send a login message.
            return "Please login";

        }
        // If the `username` cookie is not presented, send a login request message: `Please login`.
        return "Please login";
    }
}
