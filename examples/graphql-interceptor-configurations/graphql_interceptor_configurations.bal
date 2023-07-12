import ballerina/graphql;
import ballerina/log;
import ballerina/time;

// Configure the behavior of the interceptor.
@graphql:InterceptorConfig {
    // Change the scope of the interceptor.
    global: false
}
readonly service class LogExecutionTime {
    *graphql:Interceptor;

    isolated remote function execute(graphql:Context context, graphql:Field 'field)
    returns anydata|error {
        // Access the current execution field name using the `graphql:Field` object.
        string fieldName = 'field.getName();

        // Get execution start time.
        time:Utc startUtc = time:utcNow();

        // Invoke the next interceptor or resolver.
        var data = context.resolve('field);

        // Get execution end time.
        time:Utc endUtc = time:utcNow();

        // Calculate the execution time.
        time:Seconds executionTime = time:utcDiffSeconds(endUtc, startUtc);

        // Log the execution time.
        log:printInfo(string `execution time of the "${fieldName}" field: ${executionTime}s`);

        // Returns the execution result of the next interceptor or the resolver.
        return data;
    }
}

// Define the type Name.
public type Name record {|
    string first;
    string last;
|};

@graphql:ServiceConfig {
    // Insert the service interceptor.
    interceptors: new LogExecutionTime()
}
service /graphql on new graphql:Listener(9090) {

    isolated resource function get name() returns Name {
        return {
            first: "GraphQL",
            last: "Interceptors"
        };
    }
}
