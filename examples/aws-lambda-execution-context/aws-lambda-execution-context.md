# AWS Lambda execution context

The example below demonstrates how the execution context information of an AWS function can be retrieved.

For more information, see the [AWS Lambda learn guide](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/aws-lambda/).

## Set up the prerequisites

For instructions, see [Set up the prerequisites](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/aws-lambda/#set-up-the-prerequisites).

## Write the function

Follow the steps below to write the function.

1. Execute the command below to create a new Ballerina package.

::: out bal_new.out :::

2. Replace the content of the generated Ballerina file with the content below.

::: code aws-lambda-execution-context.bal :::

## Build the function

Execute the command below to generate the AWS Lambda artifacts.

::: out bal_build.out :::

## Deploy the function

Execute the AWS CLI command given by the compiler to create and publish the functions by replacing the respective AWS `$LAMBDA_ROLE_ARN`, `$REGION_ID`, and `$FUNCTION_NAME` values given in the command with your values. 

>**Tip:** For instructions on getting the values, see [Set up an AWS account](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/aws-lambda/#set-up-an-aws-account).

::: out aws_deploy.out :::

## Invoke the function

Execute the commands below to invoke the function.

::: out invoke_functions.out :::
