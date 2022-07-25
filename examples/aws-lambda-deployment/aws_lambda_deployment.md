# AWS Lambda

AWS Lambda is an event driven, serverless computing platform. Ballerina functions can be deployed in AWS Lambda by annotating a Ballerina function with `@awslambda:Function`.

::: code aws_lambda_deployment.bal :::

Create a ballerina package and replace the content of the generated ballerina file with the content above.
::: out bal_new.out :::

Build the Ballerina program to generate the AWS Lambda artifacts
::: out bal_build.out :::

Execute the AWS CLI commands to create and publish the functions; and set your respective AWS `$LAMBDA_ROLE_ARN`, `$REGION_ID`, and `$FUNCTION_NAME` values. 
For instructions on getting the value for the`$LAMBDA_ROLE_ARN`, see [AWS Lambda deployment](/learn/deployment/aws-lambda/).
::: out aws_deploy.out :::

Invoke the functions.
::: out invoke_functions.out :::

To invoke the `notifyS3` function, it needs to be registered in the S3 bucket.
For registration and execution details, see [AWS Lambda deployment](/learn/deployment/aws-lambda/).
