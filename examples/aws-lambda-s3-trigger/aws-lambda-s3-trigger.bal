import ballerina/io;
import ballerinax/awslambda;

@awslambda:Function
public function notifyS3(awslambda:Context ctx,
        awslambda:S3Event event) returns json {
    io:println(event.Records[0].s3.'object.key);
    return event.Records[0].s3.'object.key;
}
