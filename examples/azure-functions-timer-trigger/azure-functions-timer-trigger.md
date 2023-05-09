# Azure Functions timer trigger

This example demonstrates how a function can be scheduled to execute periodically by the Azure Functions app. Once the function is executed, the timer details will be stored in the selected queue storage for every invocation.

For more information, see the [Azure deployment guide](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/azure-functions/).

## Set up the prerequisites

For instructions, see [Set up the prerequisites](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/azure-functions/#set-up-the-prerequisites).

## Write the function

Follow the steps below to write the function.

1. Execute the command below to create a new Ballerina package.

::: out bal_new.out :::

2. Replace the content of the generated Ballerina file with the content below.

::: code azure-functions-timer-trigger.bal :::

## Build the function

Execute the command below to generate the Azure Functions artifacts.

::: out bal_build.out :::

## Deploy the function

Execute the Azure CLI command given by the compiler to create and publish the functions by replacing the sample app name given in the command with your respective Azure `<function_app_name>`.

>**Tip:** For instructions on getting the values, see [Set up the prerequisites](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/azure-functions/#set-up-the-prerequisites).

## Invoke the function

The `timer` function is triggered by the Azure Functions app from a timer. You can check the queue storage to see the output. 
