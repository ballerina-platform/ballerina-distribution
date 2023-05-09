# AWS Lambda S3 trigger

This sample creates a function, which will be executed for each object creation in AWS S3.

For more information, see the [AWS Lambda learn guide](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/aws-lambda/).

## Set up the prerequisites

For instructions, see [Set up the prerequisites](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/aws-lambda/#set-up-the-prerequisites).

## Write the function

Follow the steps below to write the function.

1. Execute the command below to create a new Ballerina package.

::: out bal_new.out :::

2. Replace the content of the generated Ballerina file with the content below.

::: code aws-lambda-s3-trigger.bal :::

## Build the function

Execute the command below to generate the AWS Lambda artifacts.

::: out bal_build.out :::

## Deploy the function

Execute the AWS CLI command given by the compiler to create and publish the functions by replacing the respective AWS `$LAMBDA_ROLE_ARN`, `$REGION_ID`, and `$FUNCTION_NAME` values given in the command with your values.

>**Tip:** For instructions on getting the values, see [Set up an AWS account](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/aws-lambda/#set-up-an-aws-account).

::: out aws_deploy.out :::

## Invoke the function

Follow the instructions below to create an S3 bucket in AWS for invoking this function.

1. Go to the [AWS S3](https://s3.console.aws.amazon.com/s3/) portal and create a bucket.
2. Click on the created bucket, go to the **Properties** tab, and click **Create event notification** under the **Event notifications** section.
3. Enable **All object create events** under event types. 
4. Select the AWS Lambda function as the destination.
5. Select the `notifyS3` Lambda function from the dropdown.
6. Click **Upload** to upload an object to the S3 bucket.
7. Go to the AWS Lambda function and check the logs via CloudWatch to see the object name in the logs.
