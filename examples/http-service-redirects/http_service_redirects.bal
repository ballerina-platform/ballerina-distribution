import ballerina/http;

service / on new http:Listener(9092) {

    resource function get redirect() returns http:TemporaryRedirect {
        // Return a redirect response record with the location header.
        return {
            headers: {
                "Location": "http://localhost:9090/albums"
            }
        };
    }
}
