import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // A client object is created by applying `new` to a client class.
    http:Client httpClient = check new ("https://api.github.com");

    // The remote method calls use the `->` syntax. This enables the sequence diagram view.
    http:Response resp =
                    check httpClient->get("/orgs/ballerina-platform/repos");

    io:println(resp.statusCode);
}
