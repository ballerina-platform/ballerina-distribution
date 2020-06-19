// This demonstrates different ways to mock a client object.
import ballerina/test;
import ballerina/http;
import ballerina/email;

// This is the test double of `http:Client` object with the
// implementation of required functions.
public type MockHttpClient client object {
    public remote function get(@untainted string path,
        public http:RequestMessage message = ()) returns
            http:Response|http:ClientError {

        http:Response res = new;
        res.statusCode = 500;
        return res;
    }
};

@test:Config {}
function testPerformGet() {
    http:Response mockResponse = new;

    // This creates and assigns the defined test-double.
    clientEndpoint = <http:Client>test:mock(http:Client, new MockHttpClient());
    http:Response res = performGet();
    test:assertEquals(res.statusCode, 500);

    // This creates and assigns a default mock object which subsequently needs to stubbed.
    clientEndpoint = <http:Client>test:mock(http:Client);
    // This stubs the `get` function to return the specified HTTP response.
    test:prepare(clientEndpoint).when("get").thenReturn(new http:Response());
    res = performGet();
    test:assertEquals(res.statusCode, 200);

    mockResponse.statusCode = 401;
    // This stubs the `get` function to return the specified HTTP response
    // for each call. The first call will return the `200` status code and
    // the second call will return the status code `403`.
    test:prepare(clientEndpoint).when("get")
        .thenReturnSequence(new http:Response(), mockResponse);
    res = performGet();
    test:assertEquals(res.statusCode, 401);

    mockResponse.statusCode = 403;
    // This stubs the `get` function to return the specified HTTP response
    // when a specific argument is passed.
    test:prepare(clientEndpoint).when("get").withArguments("/headers")
        .thenReturn(mockResponse);
    res = performGet();
    test:assertEquals(res.statusCode, 403);

    mockResponse.statusCode = 404;
    // The object and record types should be denoted by the `test:ANY` constant
    test:prepare(clientEndpoint).when("get")
        .withArguments("/get?test=123", test:ANY).thenReturn(mockResponse);
    res = performGet();
    test:assertEquals(res.statusCode, 404);
}

@test:Config {}
function testSendNotification() {

    smtpClient = <email:SmtpClient>test:mock(email:SmtpClient);
    // This stubs the `send` method of the `mockSmtpClient` to do nothing.
    // This is used for functions with optional or no
    // return types
    test:prepare(smtpClient).when("send").doNothing();
    string[] emailIds = ["user1@test.com", "user2@test.com"];
    error? err = sendNotification(emailIds);
    test:assertEquals(err, ());

}

@test:Config {}
function testGetClientUrl() {
    string mockClientUrl = "http://foo";
    clientEndpoint = <http:Client>test:mock(http:Client);
    // This stubs the value of `url` to return the specified string.
    test:prepare(clientEndpoint).getMember("url").thenReturn(mockClientUrl);
    test:assertEquals(clientEndpoint.url, mockClientUrl);

}
