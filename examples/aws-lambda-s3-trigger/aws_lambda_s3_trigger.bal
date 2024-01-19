import ballerina/io;
import ballerinax/aws.lambda;

@lambda:Function
public function s3Trigger(lambda:Context ctx,
        lambda:S3Event event) returns json {
    io:println(event.Records[0].s3.'object.key);
    return event.Records[0].s3.'object.key;
}
