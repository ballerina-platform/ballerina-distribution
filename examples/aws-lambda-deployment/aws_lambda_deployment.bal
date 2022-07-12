import ballerinax/awslambda;
import ballerina/io;

// The `@awslambda:Function` annotation marks a function to generate an AWS Lambda function
@awslambda:Function
public function echo(awslambda:Context ctx, json input) returns json {
    return input;
}

// The `awslambda:Context` object contains request execution context information
@awslambda:Function
public function ctxinfo(awslambda:Context ctx, json input) returns json|error {
    return {
        RequestID: ctx.getRequestId(),
        DeadlineMS: ctx.getDeadlineMs(),
        InvokedFunctionArn: ctx.getInvokedFunctionArn(),
        TraceID: ctx.getTraceId(),
        RemainingExecTime: ctx.getRemainingExecutionTime()
    };
}

// If the developer knows the external service that's being used for the function, we can use built in types such as 
// `S3Event, DynamoDBEvent, SESEvent etc for data binding
@awslambda:Function
public function notifyS3(awslambda:Context ctx, awslambda:S3Event event) {
    io:println(event.Records[0].s3.'object.key);
}
