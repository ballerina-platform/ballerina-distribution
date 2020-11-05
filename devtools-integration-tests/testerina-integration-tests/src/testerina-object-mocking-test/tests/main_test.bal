import ballerina/email;
import ballerina/http;
import ballerina/test;

// Mock object definition
public client class MockHttpClient {
    public string url = "http://mockUrl";

    public remote function get(@untainted string path, http:RequestMessage message = (), 
        http:TargetType targetType = http:Response) returns http:Response|http:ClientError {
            http:Response res = new;
            res.statusCode = 500;
            return res;
    }
}

@test:Config {}
function testUserDefinedMockObject() {

    clientEndpoint = <http:Client>test:mock(http:Client, new MockHttpClient());
    http:Response res = doGet();
    test:assertEquals(res.statusCode, 500);
    test:assertEquals(getClientUrl(), "http://mockUrl");
}

@test:Config {}
function testProvideAReturnValue() {

    http:Client mockHttpClient = <http:Client>test:mock(http:Client);
    http:Response mockResponse = new;
    mockResponse.statusCode = 500;

    test:prepare(mockHttpClient).when("get").thenReturn(mockResponse);
    clientEndpoint = mockHttpClient;
    http:Response res = doGet();
    test:assertEquals(res.statusCode, 500);
}

@test:Config {}
function testProvideAReturnValueBasedOnInput() {

    http:Client mockHttpClient = <http:Client>test:mock(http:Client);
    test:prepare(mockHttpClient).when("get").withArguments("/get?test=123", test:ANY).thenReturn(new http:Response());
    clientEndpoint = mockHttpClient;
    http:Response res = doGet();
    test:assertEquals(res.statusCode, 200);
}

@test:Config {}
function testProvideErrorAsReturnValue() {

    email:SmtpClient mockSmtpClient = <email:SmtpClient>test:mock(email:SmtpClient);
    smtpClient = mockSmtpClient;

    string[] emailIds = ["user1@test.com", "user2@test.com"];
    error? errMock = error("Email sending error", message = "email sending failed");
    test:prepare(mockSmtpClient).when("send").thenReturn(errMock);
    error? err = sendNotification(emailIds);
    test:assertTrue(err is error);
}

@test:Config {}
function testDoNothing() {

    email:SmtpClient mockSmtpClient = <email:SmtpClient>test:mock(email:SmtpClient);
    http:Response mockResponse = new;
    mockResponse.statusCode = 500;

    test:prepare(mockSmtpClient).when("send").doNothing();
    smtpClient = mockSmtpClient;

    string[] emailIds = ["user1@test.com", "user2@test.com"];
    error? err = sendNotification(emailIds);
    test:assertEquals(err, ());
}

@test:Config {}
function testMockMemberVarible() {
    string mockClientUrl = "http://foo";
    http:Client mockHttpClient = <http:Client>test:mock(http:Client);
    test:prepare(mockHttpClient).getMember("url").thenReturn(mockClientUrl);

    clientEndpoint = mockHttpClient;
    test:assertEquals(getClientUrl(), mockClientUrl);
}

@test:Config {}
function testProvideAReturnSequence() {
    http:Client mockHttpClient = <http:Client>test:mock(http:Client);
    http:Response mockResponse = new;
    mockResponse.statusCode = 500;

    test:prepare(mockHttpClient).when("get").thenReturnSequence(new http:Response(), mockResponse);
    clientEndpoint = mockHttpClient;
    http:Response res = doGetRepeat();
    test:assertEquals(res.statusCode, 500);
}
