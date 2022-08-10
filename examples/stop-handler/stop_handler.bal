import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;

string[] fruitBasket = ["Apple", "Orange"];

function init() {
    io:println("initial items in fruit basket: " + fruitBasket.toString());

    // Registers a function that will be called during graceful shutdown.
    runtime:onGracefulStop(stopHandlerFunc);
}

public function stopHandlerFunc() returns error? {
    // Remove all elements from the array.
    fruitBasket.removeAll();
    io:println("after removed all fruit items: " + fruitBasket.toString());
}

service / on new http:Listener(9090) {
    
    resource function post addToBasket(@http:Payload string fruit) returns string[] {
        // Add an element to the array.
        fruitBasket.push(fruit);
        io:println("after added a fruit item: " + fruitBasket.toString());
        return fruitBasket;
    }
}
