# AWS Lambda S3 trigger

AWS Lambda is an event driven, serverless computing platform. Ballerina functions can be deployed in AWS Lambda by annotating a Ballerina function with `@awslambda:Function`, which should have the `function (awslambda:Context, json|EventType) returns json|error` function signature. For more information, see the [AWS Lambda learn guide](/learn/run-in-the-cloud/function-as-a-service/aws-lambda/).

## Set up the prerequisites

For instructions, see [Set up the prerequisites](/learn/run-in-the-cloud/function-as-a-service/aws-lambda/#set-up-the-prerequisites).

## Create a Ballerina package

Execute the command below to create a new Ballerina package.

::: out bal_new.out :::

## Replace the code

Replace the content of the generated Ballerina file with the content below.

::: code aws-lambda-s3-trigger.bal :::

## Build the Ballerina program 

Execute the command below to generate the AWS Lambda artifacts.

::: out bal_build.out :::

## Deploy the function

Execute the AWS CLI commands to create and publish the functions by setting your respective AWS `$LAMBDA_ROLE_ARN`, `$REGION_ID`, and `$FUNCTION_NAME` values. 

>**Tip:** For instructions on getting the value for the`$LAMBDA_ROLE_ARN`, see [AWS Lambda deployment](/learn/run-in-the-cloud/function-as-a-service/aws-lambda/).

::: out aws_deploy.out :::

## Invoke the function

To invoke this function, create an S3 bucket in AWS.
1. Go to [AWS S3](https://s3.console.aws.amazon.com/s3/) portal and create a bucket.
2. Click on the created bucket, go to the **Properties** tab, and click on the **Create event notification** under the **Event notifications** section.
3. Enable `All object create events` under event types. Select the Lambda function as the destination, and choose the `notifyS3` Lambda function from the dropdown.

Now, click **Upload** to upload an object to the S3 bucket, and view the Lambda logs via CloudWatch to see the object name.

::: out invoke_functions.out :::
