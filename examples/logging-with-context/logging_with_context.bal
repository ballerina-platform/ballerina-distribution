import ballerina/log;
import ballerina/time;

public type User record {|
    string name;
    int age;
|};

public function main() {
    // Log with key-value pairs for additional context
    log:printInfo("User authentication attempt", userId = "john123", sessionId = "abc-def-ghi");

    // Log with different data types
    log:printInfo("Processing order", orderId = 845315, amount = 99.99, items = 3, success = true);

    // Log with structured data
    User user = {name: "Alice", age: 25};
    log:printInfo("User profile loaded", user = user);

    // Log with function pointers for dynamic values
    log:printInfo("System status",
            current_time = isolated function() returns string {
                return time:utcToString(time:utcNow());
            });

    // Log with templates for formatted context
    string productName = "Laptop";
    int quantity = 5;
    log:printInfo(`Processing inventory update`,
            details = `Product: ${productName}, Quantity: ${quantity}`);
}
