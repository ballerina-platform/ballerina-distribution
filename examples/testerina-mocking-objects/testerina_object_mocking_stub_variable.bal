// This is another example for stubbing a member variable.
import ballerina/test;
import ballerina/http;
import ballerina/io;

// This is a global http client with the backend URL.
http:Client clientEndpoint = new("http://postman-echo.com");

// This returns the `url` member variable from the HTTP Client object.
function getClientUrl() returns string {
    io:println("Mock client url value: " + clientEndpoint.url);
    return clientEndpoint.url;
}

@test:Config {}
function testGetClientUrl() {
    // This is the mock url value to return.
    string mockClientUrl = "http://foo";

    // This creates a default mock object and  assigns the mock client
    // to the real which subsequently needs to stubbed.
    clientEndpoint = <http:Client>test:mock(http:Client);

    // This stubs the retrieval of the specifed
    // member variable to return the `mockClientUrl`.
    test:prepare(clientEndpoint).getMember("url").thenReturn(mockClientUrl);

    // This verifies that the url is equal to the value
    // specified when stubbing.
    test:assertEquals(getClientUrl(), mockClientUrl);

}
