import ballerina/http;
import ballerina/log;

// Create an [HTTP client](https://docs.central.ballerina.io/ballerina/http/latest/http/clients/Client) that can send HTTP/2 messages.
// HTTP version is set to 2.0.
http:Client clientEP =
        checkpanic new ("http://localhost:7090", {httpVersion: "2.0"});

public function main() {

    http:Request serviceReq = new;
    http:HttpFuture httpFuture = new;
    // [Submit a request](https://docs.central.ballerina.io/ballerina/http/latest/http/clients/Client#submit).
    var submissionResult = clientEP->submit("GET", "/http2Service", serviceReq);

    if (submissionResult is http:HttpFuture) {
        httpFuture = submissionResult;
    } else {
        log:printError("Error occurred while submitting a request",
            'error = submissionResult);
        return;
    }

    http:PushPromise?[] promises = [];
    int promiseCount = 0;
    // [Check if promises exists](https://docs.central.ballerina.io/ballerina/http/latest/http/clients/Client#hasPromise).
    boolean hasPromise = clientEP->hasPromise(httpFuture);

    while (hasPromise) {
        http:PushPromise pushPromise = new;
        // [Get the next promise](https://docs.central.ballerina.io/ballerina/http/latest/http/clients/Client#getNextPromise).
        var nextPromiseResult = clientEP->getNextPromise(httpFuture);

        if (nextPromiseResult is http:PushPromise) {
            pushPromise = nextPromiseResult;
        } else {
            log:printError("Error occurred while fetching a push promise",
                'error = nextPromiseResult);
            return;
        }
        log:printInfo("Received a promise for " + pushPromise.path);

        if (pushPromise.path == "/resource2") {
            // The client is not interested in receiving `/resource2`.
            // Therefore, [reject the promise](https://docs.central.ballerina.io/ballerina/http/latest/http/clients/Client#rejectPromise).
            clientEP->rejectPromise(pushPromise);

            log:printInfo("Push promise for resource2 rejected");
        } else {
            // Store the required promises.
            promises[promiseCount] = pushPromise;

            promiseCount = promiseCount + 1;
        }
        hasPromise = clientEP->hasPromise(httpFuture);
    }

    http:Response response = new;
    // [Get the requested resource](https://docs.central.ballerina.io/ballerina/http/latest/http/clients/Client#getResponse).
    var result = clientEP->getResponse(httpFuture);

    if (result is http:Response) {
        response = result;
    } else {
        log:printError("Error occurred while fetching response",
                'error = <error>result);
        return;
    }

    var responsePayload = response.getJsonPayload();
    if (responsePayload is json) {
        log:printInfo("Response : " + responsePayload.toJsonString());
    } else {
        log:printError("Expected response payload not received",
          'error = responsePayload);
    }

    // Fetch required promise responses.
    foreach var p in promises {
        http:PushPromise promise = <http:PushPromise>p;
        http:Response promisedResponse = new;
        var promisedResponseResult = clientEP->getPromisedResponse(promise);
        if (promisedResponseResult is http:Response) {
            promisedResponse = promisedResponseResult;
        } else {
            log:printError("Error occurred while fetching promised response",
                'error = promisedResponseResult);
            return;
        }
        var promisedPayload = promisedResponse.getJsonPayload();
        if (promisedPayload is json) {
            log:printInfo("Promised resource : " +
                           promisedPayload.toJsonString());
        } else {
            log:printError("Expected promised response payload not received",
                'error = promisedPayload);
        }
    }
}
