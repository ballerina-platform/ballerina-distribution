# AWS Lambda

AWS Lambda is an event driven, serverless computing platform.
Ballerina functions can be deployed in AWS Lambda by annotating
a Ballerina function with "@awslambda:Function", which should have
the function signature `function (awslambda:Context, json|EventType) returns json|error`.<br/><br/>
For more information, see the [AWS Lambda Deployment Guide](https://ballerina.io/learn/deployment/aws-lambda/).

::: code aws_lambda_deployment.bal :::

::: out aws_lambda_deployment.out :::