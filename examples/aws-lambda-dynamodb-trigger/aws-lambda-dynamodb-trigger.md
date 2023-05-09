# AWS Lambda DynamoDB trigger

This sample creates a function, which will be executed for each entry added to a database in the DynamoDB.

For more information, see the [AWS Lambda learn guide](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/aws-lambda/).

## Set up the prerequisites

For instructions, see [Set up the prerequisites](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/aws-lambda/#set-up-the-prerequisites).

## Write the function

Follow the steps below to write the function.

1. Execute the command below to create a new Ballerina package.

::: out bal_new.out :::

2. Replace the content of the generated Ballerina file with the content below.

::: code aws-lambda-dynamodb-trigger.bal :::

## Build the function 

Execute the command below to generate the AWS Lambda artifacts.

::: out bal_build.out :::

## Deploy the function

Execute the AWS CLI command given by the compiler to create and publish the functions by replacing the respective AWS `$LAMBDA_ROLE_ARN`, `$REGION_ID`, and `$FUNCTION_NAME` values given in the command with your values.

>**Tip:** For instructions on getting the values, see [Set up an AWS account](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/aws-lambda/#set-up-an-aws-account).

::: out aws_deploy.out :::

## Invoke the function

Follow the instructions below to create a DynamoDB table for invoking this function.

1. Navigate to [**roles**](https://console.aws.amazon.com/iamv2/home#/roles), and add `AWSLambdaDynamoDBExecutionRole` to the role you created in [Set up the prerequisites](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/aws-lambda/#set-up-the-prerequisites).
2. Go to [DynamoDB](https://us-west-1.console.aws.amazon.com/dynamodbv2).
3. Click **Create Table**, enter the table name and partition key, and create the table (if you already have a table created, you can skip this step).
4. Click on the DynamoDB table you created, and then click the **Exports and streams** tab.
5. Click **enable DynamoDB stream details**, and select the key attributes only for the event type.
6. Once it is enabled, click **Create a trigger**, select the `notifyDynamoDB` from the dropdown, and create a trigger.
7. Go to [**Items**](https://us-west-1.console.aws.amazon.com/dynamodbv2) in the DynamoDB, select the table, and click **Create item** to add an entry to the DynamoDB table to invoke the Lambda function.
8. Go to the AWS Lambda function and check the logs via CloudWatch to see the object identifier in the logs.
