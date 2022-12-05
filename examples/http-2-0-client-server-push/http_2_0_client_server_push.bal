import ballerina/http;
import ballerina/log;

// Create an HTTP client that can send HTTP/2 messages.
http:Client clientEP = check new ("localhost:9090");

public function main() returns error? {

    http:Request serviceReq = new;
    // Submit a request.
    http:HttpFuture httpFuture = check clientEP->submit("GET", "/http2Service", serviceReq);

    http:PushPromise?[] promises = [];
    int promiseCount = 0;
    // Check if promises exists.
    boolean hasPromise = clientEP->hasPromise(httpFuture);

    while hasPromise {
        // Get the next promise.
        http:PushPromise pushPromise = check clientEP->getNextPromise(httpFuture);
        log:printInfo("Received a promise for " + pushPromise.path);

        if pushPromise.path == "/resource2" {
            // The client is not interested in receiving `/resource2`.
            // Therefore, reject the promise.
            clientEP->rejectPromise(pushPromise);
            log:printInfo("Push promise for resource2 rejected");
        } else {
            // Store the required promises.
            promises[promiseCount] = pushPromise;
            promiseCount = promiseCount + 1;
        }
        hasPromise = clientEP->hasPromise(httpFuture);
    }

    // Get the requested resource.
    http:Response response = check clientEP->getResponse(httpFuture);
    json responsePayload = check response.getJsonPayload();
    log:printInfo("Response : " + responsePayload.toJsonString());

    // Fetch required promise responses.
    foreach var p in promises {
        http:PushPromise promise = <http:PushPromise>p;
        http:Response promisedResponse = check clientEP->getPromisedResponse(promise);
        json promisedPayload = check promisedResponse.getJsonPayload();
        log:printInfo("Promised resource : " + promisedPayload.toJsonString());
    }
}
