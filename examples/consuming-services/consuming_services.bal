import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // A client object is created by applying `new` to a client class.
    http:Client httpClient = check new ("https://api.github.com/");

    // Remote method calls use `->` syntax. This enables sequence diagram view.
    http:Response resp =
                    check httpClient->get("/orgs/ballerina-platform/repos");

    io:println(resp.statusCode);
}
