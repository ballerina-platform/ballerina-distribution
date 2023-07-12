import ballerinax/awslambda;
import ballerina/io;

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
