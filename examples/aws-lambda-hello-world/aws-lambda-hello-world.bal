import ballerina/io;
import ballerinax/awslambda;

// The `@awslambda:Function` annotation marks a function to generate an AWS Lambda function.
@awslambda:Function
public function echo(awslambda:Context ctx, json input) returns json {
    io:println(input.toJsonString());
    return input;
}
