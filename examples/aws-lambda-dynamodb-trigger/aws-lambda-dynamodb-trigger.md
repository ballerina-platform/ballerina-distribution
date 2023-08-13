# AWS Lambda - DynamoDB trigger

This example creates a function, which will be executed for each entry added to a database in the [DynamoDB](https://aws.amazon.com/dynamodb/).

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

::: out aws_deploy.out :::

## Invoke the function

Follow the instructions below to create a DynamoDB table for invoking this function.

1. In the IAM Console, click the corresponding role in the list, and click **Add permissions**.
2. Select **attach policies** from the drop-down menu, and add the **AWSLambdaDynamoDBExecutionRole** to the role.
3. Go to [DynamoDB](https://console.aws.amazon.com/dynamodbv2), and from the drop-down menu at the top RHS of the screen, select the **AWS region** in which you created the user and role.
4. Click **Create Table**, enter a table name and a partition key, and create the table (if you already have a table created, you can skip this step).
5. Click on the DynamoDB table you created, and then click the **Exports and streams** tab.
6. Click **Turn on** under **DynamoDB stream details**, select **Key attributes only** for the event type, and click **Turn on stream**.
8. Under the **Trigger** section, click **Create trigger**, select the `dynamoDBTrigger` from the drop-down, and click **Create trigger**.
9. Click **Explore table items**, and click **Create items** under the **Items returned** section.
10. Enter a value under the **Attributes** section to add an entry to the DynamoDB table to invoke the Lambda function, and click **Create item**.
11. Click the **Monitor** tab of the Lambda function in the AWS Management Console, and click **View CloudWatch logs** to check the logs via CloudWatch.
12. Under **Log streams** in CloudWatch, click on the topmost stream in the list and verify the object name in the logs.
13. Go to the AWS Lambda function and check the logs via CloudWatch to see the object identifier in the logs.
