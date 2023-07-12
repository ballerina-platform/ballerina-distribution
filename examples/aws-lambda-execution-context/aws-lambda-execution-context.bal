import ballerinax/awslambda;

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
