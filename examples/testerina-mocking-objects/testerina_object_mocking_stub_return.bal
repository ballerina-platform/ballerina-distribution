// This is another example for stubbing a member functions.
import ballerina/test;
import ballerina/http;
import ballerina/io;

// This is a global http client with the backend URL
http:Client clientEndpoint = new("http://postman-echo.com");

// This function sends two `GET` requests to the specified
// endpoint and returns the response
function performGet() returns http:Response {

    io:println("Executing the 1st GET request");

    // This executes the first get request
    http:Response|error result = clientEndpoint->get("/headers");

    http:Response response = <http:Response>result;
    io:println("Status code: " + response.statusCode.toString());

    // If the status code of the first get request is `200`
    // then the second request is executed
    if(response.statusCode == 200) {
        io:println("Executing the 2nd GET request");
        http:Request req = new;
        req.addHeader("Sample-Name", "http-client-connector");
        result = clientEndpoint->get("/get?test=123", req);
        response = <http:Response>result;
        io:println("Status code: " + response.statusCode.toString());
    }
    return response;
}

@test:Config {}
function testPerformGet1() {
    io:println("I'm the testPerformGet1 function");
    // This creates a default mock object which subsequently needs to stubbed.
    http:Client mockHttpClient = <http:Client>test:mock(http:Client);

    // This creates the HTTP response to be used for stubbing.
    http:Response mockResponse = new;
    mockResponse.statusCode = 404;

    // This stubs the `get()` function of the mockHttpClient
    // to return the specified HTTP response.
    test:prepare(mockHttpClient).when("get").thenReturn(mockResponse);

    // This assigns the mock client to the real.
    clientEndpoint = mockHttpClient;

    // This invokes the `performGet()` function.
    http:Response res = performGet();

    // This verifies that the response is equal to the
    // value specified when stubbing.
    test:assertEquals(res.statusCode, 404);

}

@test:Config {}
function testPerformGet2() {
    io:println("I'm the testPerformGet2 function");

    // This creates a default mock object and  assigns the mock client
    // to the real which subsequently needs to stubbed.
    clientEndpoint = <http:Client>test:mock(http:Client);

    // This creates one of the HTTP response to be used for stubbing.
    http:Response mockResponse = new;
    mockResponse.statusCode = 404;

    // This stubs the `get()` function of the mockHttpClient to return.
    test:prepare(clientEndpoint).when("get").thenReturn(new http:Response());

    // This invokes the `performGet()` function
    // This invokes the `get()` function twice and both the calls
    // will return the status code `200`.
    http:Response res = performGet();

    // This verifies that the response is equal to the value
    // specified when stubbing.
    test:assertEquals(res.statusCode, 200);

    // This stubs the `get()` function of the mockHttpClient to return the
    //  status 404 when the `get()` is called with the specified argument.
    test:prepare(clientEndpoint).when("get")
        .withArguments("/headers").thenReturn(mockResponse);

    // This will execute only the first call to `get()`. Since the status
    // code is not `200` the second call to `get()` will not be executed.
    res = performGet();

    // This verifies that the response is equal to the value
    // specified when stubbing.
    test:assertEquals(res.statusCode, 404);

}

@test:Config {}
function testPerformGet3() {
    io:println("I'm the testPerformGet3 function");

    // This creates a default mock object which subsequently needs to stubbed
    http:Client mockHttpClient = <http:Client>test:mock(http:Client);

    // This creates one of the HTTP response to be used for stubbing
    http:Response mockResponse = new;
    mockResponse.statusCode = 404;

    // This stubs the `get()` function of the mockHttpClient to return
    // the respective HTTP response for each call
    // The first call to `get()` will return the `200` status code and
    // the second `get()` will return the status code `404`
    test:prepare(mockHttpClient).when("get")
        .thenReturnSequence(new http:Response(), mockResponse);

    // This assigns the mock client to the real
    clientEndpoint = mockHttpClient;

    // This invokes the `performGet()` function
    http:Response res = performGet();

    // This verifies that the response is equal to the value
    // specified when stubbing
    test:assertEquals(res.statusCode, 404);

}

@test:Config {}
function testPerformGet4() {
    io:println("I'm the testPerformGet4 function");

    // This creates a default mock object which subsequently needs to stubbed
    http:Client mockHttpClient = <http:Client>test:mock(http:Client);

    // This creates the HTTP response to be used for stubbing
    http:Response mockResponse = new;
    mockResponse.statusCode = 404;

    // This stubs the `get()` function of the mockHttpClient to return
    test:prepare(mockHttpClient).when("get").thenReturn(new http:Response());

    // This stubs the `get()` to return the specified HTTP response
    // when the `get()` is called with the specified arguments.
    // The object and record types should be denoted by the `test:ANY` constant
    test:prepare(mockHttpClient).when("get")
        .withArguments("/get?test=123", test:ANY).thenReturn(mockResponse);

    // This assigns the mock client to the real
    clientEndpoint = mockHttpClient;

    // This invokes the `performGet()` function
    http:Response res = performGet();

    // This verifies that the response is equal to the value
    // specified when stubbing
    test:assertEquals(res.statusCode, 404);

}
