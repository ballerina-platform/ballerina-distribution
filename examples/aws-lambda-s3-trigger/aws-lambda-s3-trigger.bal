import ballerina/io;
import ballerinax/awslambda;

// The `@awslambda:Function` annotation marks a function to generate an AWS Lambda function.

@awslambda:Function
public function notifyS3(awslambda:Context ctx,
        awslambda:S3Event event) returns json {
    io:println(event.Records[0].s3.'object.key);
    return event.Records[0].s3.'object.key;
}