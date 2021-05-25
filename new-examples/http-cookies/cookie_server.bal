import ballerina/http;

listener http:Listener serverEP = new (9095);

service /cookieDemo on serverEP {

    resource function post login(http:Request req)
            returns http:Response|http:BadRequest {
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

                    // [Create a new cookie](https://docs.central.ballerina.io/ballerina/http/latest/classes/Cookie) by setting `name` as the `username`
                    // and `value` as the logged-in user's name.
                    http:Cookie cookie = new("username", name.toString());

                    // Set the cookies path as `/` to apply it to all the
                    // resources in the service.
                    cookie.path = "/";

                    http:Response response = new;

                    // [Add the created cookie to the response](https://docs.central.ballerina.io/ballerina/http/latest/classes/Response#addCookie).
                    response.addCookie(cookie);

                    // Set a message payload to inform that the login has
                    // been succeeded.
                    response.setTextPayload("Login succeeded");
                    return response;
                }
            }
        }
        return {body: "Invalid request payload"};
    }

    resource function get welcome(http:Request req) returns string {
        // [Retrieve cookies from the request](https://docs.central.ballerina.io/ballerina/http/latest/classes/Request#getCookies).
        http:Cookie[] cookies = req.getCookies();

        // Get the cookie value of the `username`.
        http:Cookie[] usernameCookie = cookies.filter(function
                                (http:Cookie cookie) returns boolean {
            return cookie.name == "username";
        });

        if (usernameCookie.length() > 0) {
            string? user = usernameCookie[0].value;
            if (user is string) {
                // Respond with the username added to the welcome message.
                return "Welcome back " + <@untainted> user;

            } else {
                // If the user is `nil`, send a login message.
                return "Please login";
            }
        } else {
            // If the `username` cookie is not presented, send a login message.
            return "Please login";
        }
    }
}
