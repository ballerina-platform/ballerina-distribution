import ballerina/io;
import ballerinax/awslambda;

// The `@awslambda:Function` annotation marks a function to generate an AWS Lambda function.
@awslambda:Function
public function echo(awslambda:Context ctx, json input) returns json {
    io:println(input.toJsonString());
    return input;
}

// The `awslambda:Context` object contains request execution context information.
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
