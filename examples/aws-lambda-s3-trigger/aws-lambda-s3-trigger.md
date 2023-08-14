# AWS Lambda - S3 trigger

This example creates a function, which will be executed for each object creation in AWS S3.

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

::: out aws_deploy.out :::

## Invoke the function

Follow the instructions below to create an S3 bucket in AWS for invoking this function.

1. Go to the [AWS S3](https://s3.console.aws.amazon.com/s3/) portal and create a bucket.
<<<<<<< HEAD
   >**Note:** Make sure to select the same **AWS region** in which you created the AWS user and role when creating the S3 bucket.
2. Click on the created bucket, go to the **Properties** tab, and click **Create event notification** under the **Event notifications** section.
3. Enable **All object create events** under event types. 
=======
   > **Note:** Make sure to select the same **AWS region** in which you created the AWS user and role when creating the S3 bucket.
2. Click on the created bucket, go to the **Properties** tab, and click **Create event notification** under the **Event notifications** section.
3. Enable **All object create events** under event types.
>>>>>>> 2a84a2d3c676c4a3b03d236f287fef9e855a81ae
4. Under the **Destination** section, select the AWS Lambda function (i.e., `s3Trigger` in this example) from the dropdown.
5. Select the created bucket under the **Buckets** list, click **Upload**, and upload an object to the S3 bucket.
6. Under the **Functions** list of the AWS Management Console, click the AWS Lambda function, and click the **Monitor** tab.
7. If you get a **Missing permissions** notice at the top, click the **Open the IAM Console** in it.
8. In the IAM Console, click the corresponding role in the list, and click **Add permissions**.
9. Select **attach policies** from the drop-down menu, and add the **AWSLambdaBasicExecutionRole** to the role.
10. Click the **Monitor** tab of the Lambda function in the AWS Management Console, and click **View CloudWatch logs** to check the logs via CloudWatch.
11. Under **Log streams** in CloudWatch, click on the topmost stream in the list and verify the object name in the logs.
