import ballerina/io;
import ballerinax/aws.lambda;

// The `@lambda:Function` annotation marks a function to generate an AWS Lambda function.
@lambda:Function
public function echo(lambda:Context ctx, json input) returns json {
    io:println(input.toJsonString());
    return input;
}
