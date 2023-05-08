# AWS Lambda DynamoDB trigger

AWS Lambda is an event driven, serverless computing platform. Ballerina functions can be deployed in AWS Lambda by annotating a Ballerina function with `@awslambda:Function`, which should have the `function (awslambda:Context, json|EventType) returns json|error` function signature. For more information, see the [AWS Lambda learn guide](/learn/run-in-the-cloud/function-as-a-service/aws-lambda/).

## Set up the prerequisites

For instructions, see [Set up the prerequisites](/learn/run-in-the-cloud/function-as-a-service/aws-lambda/#set-up-the-prerequisites).

## Create a Ballerina package

Execute the command below to create a new Ballerina package.

::: out bal_new.out :::

## Replace the code

Replace the content of the generated Ballerina file with the content below.

::: code aws-lambda-dynamodb-trigger.bal :::

## Build the Ballerina program 

Execute the command below to generate the AWS Lambda artifacts.

::: out bal_build.out :::

## Deploy the function

Execute the AWS CLI commands to create and publish the functions by setting your respective AWS `$LAMBDA_ROLE_ARN`, `$REGION_ID`, and `$FUNCTION_NAME` values. 

>**Tip:** For instructions on getting the value for the`$LAMBDA_ROLE_ARN`, see [AWS Lambda deployment](/learn/run-in-the-cloud/function-as-a-service/aws-lambda/).

::: out aws_deploy.out :::

## Invoke the function

To invoke this function, create a DynamoDB table.
1. Go to [**roles**](https://console.aws.amazon.com/iamv2/home#/roles){:target="_blank"}, and add `AWSLambdaDynamoDBExecutionRole` to the created role in the prerequisites.
2. Go to the [DynamoDB](https://us-west-1.console.aws.amazon.com/dynamodbv2){:target="_blank"}.
3. Click **Create Table**, enter the table name, partition key, and create the table (If you already have a table created, you can skip this step).
4. Click on the DynamoDB table, and then click the **Exports and streams** tab.
5. Click **enable DynamoDB stream details**, and select the key attributes only for the event type.
6. Once it's enabled, click **Create a trigger**, select the `notifyDynamoDB` from the dropdown, and create a trigger.

Now, add an entry to the DynamoDB table to invoke the Lambda function. For this, go to <a href="https://us-west-1.console.aws.amazon.com/dynamodbv2" target="_blank">**Items**</a> in the DynamoDB, select the table, and click **Create item**. Once the item is entered into the table, go to the Lambda function, and check the logs via CloudWatch to see the object identifier in the logs.

::: out invoke_functions.out :::
