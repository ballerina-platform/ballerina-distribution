import ballerina/graphql;
import ballerina/log;

// Defines an interceptor `LogInterceptor` using a service class. It cannot have any
// `resource`/`remote` methods except the `execute()` remote method. Other methods are allowed.
readonly service class LogInterceptor {
    // Includes the `graphql:Interceptor` service object from the GraphQL package.
    *graphql:Interceptor;

    // Implement the `execute()` remote method provided by the `graphql:Interceptor` object.
    isolated remote function execute(graphql:Context context, graphql:Field 'field)
    returns anydata|error {
        // Access the current execution field name using the `graphql:Field` object.
        string fieldName = 'field.getName();

        // This log statement executes before the resolver execution.
        log:printInfo(string `Field "${fieldName}" execution started!`);

        // The `context.resolve()` function can be used to invoke the next interceptor.
        var data = context.resolve('field);

        // This log statement executes after the resolver execution.
        log:printInfo(string `Field "${fieldName}" execution completed!`);

        // Returns the execution result of the next interceptor or the resolver.
        return data;
    }
}

service /graphql on new graphql:Listener(9090) {
    @graphql:ResourceConfig {
        // Interceptor instances should be inserted using the `interceptors` field. A single
        // interceptor or an array of interceptors can be provided. The execution order of the
        // interceptor will be the order of the interceptors.
        interceptors: new LogInterceptor()
    }
    isolated resource function get name() returns string {
        log:printInfo("Executing the field \"name\"");
        return "GraphQL Interceptors";
    }
}
