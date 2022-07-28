import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;

int[] arr = [1, 2, 3];

function init() {
    io:println(arr);
    
    // Registers a function that will be called during graceful shutdown.
    runtime:onGracefulStop(stopHandlerFunc);
}

public function stopHandlerFunc() returns error? {
    arr.removeAll();
    io:println(arr);
}

service / on new http:Listener(9090) {
}
