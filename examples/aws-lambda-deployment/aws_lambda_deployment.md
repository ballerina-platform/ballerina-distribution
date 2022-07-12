# AWS Lambda

AWS Lambda is an event driven, serverless computing platform. Ballerina functions can be deployed in AWS Lambda by annotating a Ballerina function with `@awslambda:Function`.

::: code aws_lambda_deployment.bal :::

Create a ballerina package and replace the contents of the generated bal file with the contents above.
::: out bal_new.out :::

Build the Ballerina program to generate the AWS Lambda artifacts
::: out bal_build.out :::

Execute the AWS CLI commands to create and publish the functions; and set your respective AWS `$LAMBDA_ROLE_ARN`, `$REGION_ID`, and `$FUNCTION_NAME` values. The instructions for getting `$LAMBDA_ROLE_ARN` can be found on the [AWS Lambda Deployment Guide.](/learn/deployment/aws-lambda/)
::: out aws_deploy.out :::

Invoke the functions
::: out invoke_functions.out :::

To invoke the `notifyS3` function, it needs to be registered in the s3 bucket. visit the [AWS Lambda Deployment Guide](/learn/deployment/aws-lambda/) for registration and execution details.
