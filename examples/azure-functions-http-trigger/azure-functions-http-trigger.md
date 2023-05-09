# Azure Functions- HTTP trigger

This example demonstrates using an HTTP trigger to invoke an Azure function with multiple output bindings to return the HTTP response and queue output binding to write an entry to a queue.

For more information, see the [Azure Functions deployment guide](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/azure-functions/).

## Set up the prerequisites

1. Set up the [general prerequisites](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/azure-functions/#set-up-the-prerequisites).
2. Accessing the storage account that was created alongside the function app in step 1, and create a queue to hold the outputs of the function.
3. Select **Queues** in the sidebar in the storage accounts.
4. Click the **Add queue** button, and enter the same value as the value of the `queueName` property in the `QueueOutput` annotation in the [Ballerina source below](https://ballerina.io/learn/by-example/azure-functions-trigger/#write-the-function).

## Write the function

Follow the steps below to write the function.

1. Execute the command below to create a new Ballerina package.

::: out bal_new.out :::

2. Replace the content of the generated Ballerina file with the content below.

::: code azure-functions-http-trigger.bal :::

## Build the function

Execute the command below to generate the Azure Functions artifacts.

::: out bal_build.out :::

## Deploy the function

Execute the Azure CLI command given by the compiler to create and publish the functions by replacing the sample app name given in the command with your respective Azure `<function_app_name>`.

>**Tip:** For instructions on getting the values, see [Set up the prerequisites](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/azure-functions/#set-up-the-prerequisites).

## Invoke the function

Execute the commands below to invoke the function.

::: out execute_function.out :::

>**Tip:** Refresh the queue page in the portal and view the added entry.
