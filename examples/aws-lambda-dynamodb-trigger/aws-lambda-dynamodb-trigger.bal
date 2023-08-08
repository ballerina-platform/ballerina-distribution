import ballerina/io;
import ballerinax/aws.lambda;

@lambda:Function
public function dynamoDBTrigger(lambda:Context ctx,
        lambda:DynamoDBEvent event) returns json {
    io:println(event.Records[0].dynamodb.Keys.toString());
    return event.Records[0].dynamodb.Keys.toString();
}
