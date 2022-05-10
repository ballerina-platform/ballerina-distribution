// This demonstrates different ways to mock a client object.
import ballerina/test;
import ballerina/http;
import ballerina/email;

// The test double of the `http:Client` object with the
// implementation of the required functions.
public client class MockHttpClient {
    remote isolated function get(@untainted string path,
    map<string|string[]>? headers = (),
    http:TargetType targetType = http:Response) returns
    http:Response | http:PayloadType | http:ClientError {
        http:Response response = new;
        response.statusCode = 500;
        return response;
    }
}

@test:Config { }
function testTestDouble() {
    // Creates and assigns the defined test-double.
    clientEndpoint = test:mock(http:Client, new MockHttpClient());
    http:Response res = performGet();
    test:assertEquals(res.statusCode, 500);
}

@test:Config { }
function testReturn() {
    // Creates and assigns a default mock object,
    // which subsequently needs to be stubbed.
    clientEndpoint = test:mock(http:Client);
    // Stubs the `get` function to return the specified HTTP response.
    test:prepare(clientEndpoint).when("get").thenReturn(new http:Response());
    http:Response res = performGet();
    test:assertEquals(res.statusCode, 200);
}

@test:Config { }
function testReturnSequence() {
    http:Response mockResponse = new;
    mockResponse.statusCode = 404;

    clientEndpoint = test:mock(http:Client);
    // Stubs the `get` function to return the specified HTTP response
    // for each call (i.e., The first call will return the status code `200`
    // and the second call will return the status code `404`).
    test:prepare(clientEndpoint).when("get").thenReturnSequence(
        new http:Response(), mockResponse);
    http:Response res = performGet();
    test:assertEquals(res.statusCode, 404);
}

@test:Config { }
function testReturnWithArgs() {
    http:Response mockResponse = new;
    mockResponse.statusCode = 404;
    clientEndpoint = test:mock(http:Client);
    // This stubs the `get` function to return the specified HTTP response when the specified
    // argument is passed.
    test:prepare(clientEndpoint).when("get").
    withArguments("/headers").thenReturn(mockResponse);
    // The object and record types should be denoted by the `test:ANY` constant.
    test:prepare(clientEndpoint).when("get").withArguments("/get?test=123")
        .thenReturn(mockResponse);
    http:Response res = performGet();
    test:assertEquals(res.statusCode, 404);
}

@test:Config { }
function testSendNotification() {
    smtpClient = test:mock(email:SmtpClient);
    // Stubs the `send` method of the `mockSmtpClient` to do nothing.
    // This is used for functions with an optional or no return type.
    test:prepare(smtpClient).when("sendMessage").doNothing();
    string[] emailIds = ["user1@test.com", "user2@test.com"];
    error? err = sendNotification(emailIds);
    test:assertEquals(err, ());
}

@test:Config {}
function testMemberVariable() {
    string mockId = "test";
    lock {
        exampleClient = test:mock(ExampleClient);
        // Stubs the value of the `id` to return the specified string.
        test:prepare(exampleClient).getMember("id").thenReturn(mockId);
        test:assertEquals(exampleClient.id, mockId);
    }
}
