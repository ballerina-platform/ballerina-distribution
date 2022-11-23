import ballerina/http;

// Create an endpoint with port 7090 to accept HTTP requests.
listener http:Listener http2ServiceEP = new (7090);

service /http2service on http2ServiceEP {

    resource function 'default .(http:Caller caller) returns error? {

        // Send a push promise.
        http:PushPromise promise1 = new (path = "/resource1", method = "GET");
        check caller->promise(promise1);

        // Send another push promise.
        http:PushPromise promise2 = new (path = "/resource2", method = "GET");
        check caller->promise(promise2);

        // Send one more push promise.
        http:PushPromise promise3 = new (path = "/resource3", method = "GET");
        check caller->promise(promise3);

        // Construct the requested resource.
        http:Response res = new;
        json msg = {"response": {"name": "main resource"}};
        res.setPayload(msg);

        // Send the requested resource.
        check caller->respond(res);

        // Construct promised resource1.
        http:Response push1 = new;
        msg = {"push": {"name": "resource1"}};
        push1.setPayload(msg);

        // Push promised `resource1`.
        check caller->pushPromisedResponse(promise1, push1);

        // Construct promised `resource2`.
        http:Response push2 = new;
        msg = {"push": {"name": "resource2"}};
        push2.setPayload(msg);

        // Push promised `resource2`.
        check caller->pushPromisedResponse(promise2, push2);

        // Construct promised `resource3`.
        http:Response push3 = new;
        msg = {"push": {"name": "resource3"}};
        push3.setPayload(msg);

        // Push promised `resource3`.
        check caller->pushPromisedResponse(promise3, push3);
    }
}
