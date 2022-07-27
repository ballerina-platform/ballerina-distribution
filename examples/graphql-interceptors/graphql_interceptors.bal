import ballerina/graphql;
import ballerina/log;

// Define an interceptor service class named `LogInterceptor`. It cannot have
// any `resource/remote` methods except the `execute()` remote method.
readonly service class LogInterceptor {

    // Infers the `graphql:Interceptors` service object from GraphQL package.
    *graphql:Interceptor;

    // Implement the `execute()` remote function provided by the
    // `graphql:Interceptor` object. Within the function, the `graphql:Context`
    // and the `graphql:Field` object can be accessed to get the request and
    // field related information.
    isolated remote function execute(graphql:Context context,
                                     graphql:Field 'field)
                                     returns anydata|error {

        // Access the current execution field name using `graphql:Field`
        // object.
        string fieldName = 'field.getName();

        // The log statement executes before the actual resolver
        // execution.
        log:printInfo(string `Field "${fieldName}" execution started!`);

        // The `context.resolve()` function can be used to invoke the next
        // interceptor. If all the interceptors were executed, it invokes
        // the `actual resolver` function. The function returns an `anydata`
        // type value that includes the execution result of the next
        // interceptor or the actual resolver. To call the `context.resolve()`
        // function, `graphql:Field` value should be provided as the argument.
        var data = context.resolve('field);

        // This log statement executes after the resolver execution.
        log:printInfo(string `Field "${fieldName}" execution completed!`);

        // Returns the execution result of the next interceptor or the actual
        // resolver.
        return data;

    }
}

@graphql:ServiceConfig {
    // Interceptor instances should be inserted to the `interceptors` array
    // according to the execution order.
    interceptors: [new LogInterceptor()]

}
service /graphql on new graphql:Listener(4000) {
    isolated resource function get name() returns string {
        log:printInfo("Executing the field \"name\"");
        return "GraphQL Interceptors";
    }
}
