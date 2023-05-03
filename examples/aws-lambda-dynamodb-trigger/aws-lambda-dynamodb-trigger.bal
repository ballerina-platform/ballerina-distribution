import ballerina/io;
import ballerinax/awslambda;

// The `@awslambda:Function` annotation marks a function to generate an AWS Lambda function.

@awslambda:Function
public function notifyDynamoDB(awslambda:Context ctx,
        awslambda:DynamoDBEvent event) returns json {
    io:println(event.Records[0].dynamodb.Keys.toString());
    return event.Records[0].dynamodb.Keys.toString();
}
