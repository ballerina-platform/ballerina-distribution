import ballerina/io;
import ballerinax/awslambda;

@awslambda:Function
public function dynamoDBTrigger(awslambda:Context ctx,
        awslambda:DynamoDBEvent event) {
    io:println(event.Records[0].dynamodb.Keys.toString());
}
