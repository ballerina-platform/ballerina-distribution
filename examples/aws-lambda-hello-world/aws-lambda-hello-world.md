# AWS Lambda

AWS Lambda is an event driven, serverless computing platform. Ballerina functions can be deployed in AWS Lambda by annotating a Ballerina function with `@awslambda:Function`, which should have the `function (awslambda:Context, json|EventType) returns json|error` function signature. For more information, see the [AWS Lambda learn guide](/learn/run-in-the-cloud/function-as-a-service/aws-lambda/).

## Set up the prerequisites

For instructions, see [Set up the prerequisites](/learn/run-in-the-cloud/function-as-a-service/aws-lambda/#set-up-the-prerequisites).

## Create a Ballerina package

Execute the command below to create a new Ballerina package.

::: out bal_new.out :::

## Replace the code

Replace the content of the generated Ballerina file with the content below.

::: code aws-lambda-hello-world.bal :::

## Build the Ballerina program 

Execute the command below to generate the AWS Lambda artifacts.

::: out bal_build.out :::

## Deploy the function

Execute the AWS CLI commands to create and publish the functions by setting your respective AWS `$LAMBDA_ROLE_ARN`, `$REGION_ID`, and `$FUNCTION_NAME` values. 

    >**Tip:** For instructions on getting the value for the`$LAMBDA_ROLE_ARN`, see [AWS Lambda deployment](/learn/run-in-the-cloud/function-as-a-service/aws-lambda/).

::: out aws_deploy.out :::

## Invoke the function

Execute the commands below to invoke the function.

::: out invoke_functions.out :::
