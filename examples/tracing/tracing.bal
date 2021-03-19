import ballerina/http;
import ballerina/log;
import ballerina/observe;
import ballerina/lang.runtime;
import ballerinax/jaeger as _;

// Simple `Hello` HTTP Service
service /hello on new http:Listener(9234) {

    // Resource functions are invoked with the HTTP caller and the
    // incoming request as arguments.
    resource function get sayHello(http:Caller caller, http:Request req)
            returns error? {
        http:Response res = new;

        //Start a child span attaching to the generated system span.
        int spanId = check observe:startSpan("MyFirstLogicSpan");

        //Start a new root span without attaching to the system span.
        int rootParentSpanId = observe:startRootSpan("MyRootParentSpan");
        // Some actual logic will go here, and for example, we have introduced some delay with the sleep.
        runtime:sleep(1);
        //Start a new child span for the `MyRootParentSpan` span.
        int childSpanId = check observe:startSpan("MyRootChildSpan", (),
                                                            rootParentSpanId);
        // Some actual logic will go here, and for example, we have introduced some delay with the sleep.
        runtime:sleep(1);
        //Finish the `MyRootChildSpan` span.
        error? result = observe:finishSpan(childSpanId);
        if (result is error) {
            log:printError("Error in finishing span", 'error = result);
        }
        // Some actual logic will go here, and for example, we have introduced some delay with the sleep.
        runtime:sleep(1);
        //Finish the `MyRootParentSpan` span.
        result = observe:finishSpan(rootParentSpanId);
        if (result is error) {
            log:printError("Error in finishing span", 'error = result);
        }

        //Some actual logic will go here, and for example, we have introduced some delay with the sleep.
        runtime:sleep(1);

        //Finish the created child `MyFirstLogicSpan` span, which was attached to the system trace.
        result = observe:finishSpan(spanId);
        if (result is error) {
            log:printError("Error in finishing span", 'error = result);
        }
        //Use a util method to set a string payload.
        res.setPayload("Hello, World!");

        //Send the response back to the caller.
        result = caller->respond(res);

        if (result is error) {
            log:printError("Error sending response", 'error = result);
        }

        return ();
    }
}
