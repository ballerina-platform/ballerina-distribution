import ballerina/test;
import ballerina/http;

public client class MockHttpClient {
    public string url = "http://mockUrl";

     remote function get(@untainted string path, http:RequestMessage message = (),
        http:TargetType targetType = http:Response) returns http:Response | http:PayloadType |http:ClientError {
            http:Response res = new;
            res.statusCode = 500;
            return res;
    }

     remote function post(@untainted string path, http:RequestMessage message = (),
        http:TargetType targetType = http:Response) returns http:Response|http:PayloadType|http:ClientError {
            http:Response res = new;
            res.statusCode = 500;
            return res;
    }
}

@test:Config {}
function test_addOrderWithoutMock() {
    json orderPayload = {
        "Order": {
            "ID": "100500",
            "Name": "XYZ",
            "Description": "Sample order."
        }
    };

    json actual = addOrder(orderPayload);
    json expected = {"status":"Order Created.","orderId":"100500"};

    test:assertEquals(actual, expected, "Add order test failed");

}

@test:Config { dependsOn: [test_addOrderWithoutMock]}
function test_addOrderAgain() {
     json orderPayload = {
        "Order": {
            "ID": "100500",
            "Name": "XYZ",
            "Description": "Sample order."
        }
    };

    json actual = addOrder(orderPayload);
    json expected = "Order with same ID already exists";

    test:assertEquals(actual, expected, "Add order test failed");
}

// Create mock http client
http:Client mockHttpClient = <http:Client> test:mock(http:Client);

json getResponse1 = {
    "Order": {
        "ID": "100",
        "Name": "MOCK",
        "Description": "Mock Order."
    }
};

json getResponse2 = { "Error" : "Order : 200 cannot be found." };

@test:Config { dependsOn: [test_addOrderWithoutMock]}
function test_findOrder() {

    // Create a Specific response for get
    http:Response mockGetResponse = new;
    mockGetResponse.setJsonPayload(<@untainted> getResponse1);
    test:prepare(mockHttpClient).when("get").thenReturn(mockGetResponse);

    mockGetResponse = new;
    mockGetResponse.setJsonPayload(<@untainted> getResponse2);
    test:prepare(mockHttpClient).when("get").withArguments("/order/200").thenReturn(mockGetResponse);

    orderManagementClient = mockHttpClient;

    // Try to find a non existing order
    json actual = findOrder("100");
    json expected = getResponse1;
    test:assertEquals(actual, expected, "Correct mocked response not recieved");

    actual = findOrder("200");
    expected = getResponse2;
    test:assertEquals(actual, expected, "Correct mocked response not recieved");

}


json postPayload = {
    "Order": {
        "ID": "200",
        "Name": "MOCK",
        "Description": "Mock Order."
    }
};

json postResponse1 = {
    status : "Order Created.",
    orderId : "200"
};

@test:Config {
    dependsOn : [test_findOrder]
}
function test_addOrder() {
    http:Response mockPostResponse = new;
    mockPostResponse.setJsonPayload(<@untainted> postResponse1);
    test:prepare(mockHttpClient).when("post").withArguments("/order", postPayload).thenReturn(mockPostResponse);

    json actual = addOrder(postPayload);
    json expected = postResponse1;
    test:assertEquals(actual, expected, "Correct mocked response not recieved");
}
