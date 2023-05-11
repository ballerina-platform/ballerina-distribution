import ballerina/io;
import ballerinax/awslambda;

@awslambda:Function
public function s3Trigger(awslambda:Context ctx,
        awslambda:S3Event event) {
    io:println(event.Records[0].s3.'object.key);
}