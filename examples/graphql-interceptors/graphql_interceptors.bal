import ballerina/graphql;
import ballerina/log;

// Define an interceptor `LogInterceptor` using a service class. It cannot have any
// `resource`/`remote` methods except the `execute()` remote method. Other methods are allowed.
readonly service class LogInterceptor {

    // Includes the `graphql:Interceptors` service object from the GraphQL package.
    *graphql:Interceptor;

    // Implement the `execute()` remote method provided by the `graphql:Interceptor` object.
    // Within the function, the `graphql:Context` and the `graphql:Field` object can be accessed to
    // get the request and field related information.
    isolated remote function execute(graphql:Context context, graphql:Field 'field)
    returns anydata|error {

        // Access the current execution field name using the `graphql:Field` object.
        string fieldName = 'field.getName();

        // This log statement executes begore the resolver execution.
        log:printInfo(string `Field "${fieldName}" execution started!`);

        // The `context.resolve()` function can be used to invoke the next interceptor. If all the
        // interceptors were executed, it invokes the actual resolver function. The function returns
        // an `anydata` type value that includes the execution result of the next interceptor or the
        //  actual resolver. To call the `context.resolve()` function, the `graphql:Field` value
        // should be provided as the argument.
        var data = context.resolve('field);

        // This log statement executes after the resolver execution.
        log:printInfo(string `Field "${fieldName}" execution completed!`);

        // Returns the execution result of the next interceptor or the resolver.
        return data;

    }
}

@graphql:ServiceConfig {
    // Interceptor instances should be inserted to the `interceptors` array according to the
    // desired execution order.
    interceptors: [new LogInterceptor()]

}
service /graphql on new graphql:Listener(9090) {
    
    isolated resource function get name() returns string {
        log:printInfo("Executing the field \"name\"");
        return "GraphQL Interceptors";
    }
}
