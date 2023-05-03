# AWS Lambda

AWS Lambda is an event driven, serverless computing platform. Ballerina functions can be deployed in AWS Lambda by annotating a Ballerina function with `@awslambda:Function`, which should have the `function (awslambda:Context, json|EventType) returns json|error` function signature.

For more information, see the [AWS Lambda learn guide](/learn/run-in-the-cloud/function-as-a-service/aws-lambda/).

::: code aws-lambda-hello-world.bal :::

Create a Ballerina package and replace the content of the generated Ballerina file with the content above.
::: out bal_new.out :::

Build the Ballerina program to generate the AWS Lambda artifacts.
::: out bal_build.out :::

Execute the AWS CLI commands to create and publish the functions by setting your respective AWS `$LAMBDA_ROLE_ARN`, `$REGION_ID`, and `$FUNCTION_NAME` values. 

For instructions on getting the value for the`$LAMBDA_ROLE_ARN`, see [AWS Lambda deployment](/learn/run-in-the-cloud/function-as-a-service/aws-lambda/).

::: out aws_deploy.out :::

Invoke the functions.
::: out invoke_functions.out :::
