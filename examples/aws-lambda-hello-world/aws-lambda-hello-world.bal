import ballerina/log;
import ballerinax/awslambda;

// The `@awslambda:Function` annotation marks a function to generate an AWS Lambda function.
@awslambda:Function
public function echo(awslambda:Context ctx, json input) returns json {
    log:printInfo(input.toJsonString());
    return input;
}
