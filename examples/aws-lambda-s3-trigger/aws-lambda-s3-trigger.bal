import ballerina/io;
import ballerinax/aws.lambda;

@lambda:Function
public function notifyS3(lambda:Context ctx,
        lambda:S3Event event) returns json {
    io:println(event.Records[0].s3.'object.key);
    return event.Records[0].s3.'object.key;
}
