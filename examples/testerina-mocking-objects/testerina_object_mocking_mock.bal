// This is the example for creating a test double for an object.
import ballerina/test;
import ballerina/http;
import ballerina/io;

// This is a global http client with the backend URL.
http:Client clientEndpoint = new("http://postman-echo.com");

// This function sends a `GET` request to the specified
// endpoint and returns the response.
function performGet() returns http:Response {
    http:Response|error result = clientEndpoint->get("/get?test=1234");
    http:Response response = <http:Response>result;
    io:println("Status code: " + response.statusCode.toString());
    return response;
}

// The mock object that would act as the test double to the clientEndpoint.
// It should contain the specific function to replace with.
public type MockHttpClient client object {

    //The function signature should be equivalent to that of real.
    public remote function get(@untainted string path,
        public http:RequestMessage message = ())
        returns http:Response|http:ClientError {

        http:Response res = new;
        res.statusCode = 500;
        return res;
    }
};

@test:Config {}
function testPerformGet() {
    // This specifies the creation of a new instance of the
    // user-defined mock object and assigns it to the global http client.
    clientEndpoint = <http:Client>test:mock(http:Client, new MockHttpClient());

    http:Response res = performGet();

    // Verifies that the status code is set with the
    // value specified in the mock object.
    test:assertEquals(res.statusCode, 500);

}
