<<<<<<< HEAD
# Azure Functions - Timer trigger
=======
# Azure Functions timer trigger
>>>>>>> 2a84a2d3c676c4a3b03d236f287fef9e855a81ae

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

<<<<<<< HEAD
Execute the Azure CLI command given by the compiler to create and publish the functions by replacing `<function_app_name>` with your respective function app name.
=======
Execute the Azure CLI command given by the compiler to create and publish the functions by replacing `bal-bbe` with your respective function app name to invoke the function.
>>>>>>> 2a84a2d3c676c4a3b03d236f287fef9e855a81ae

## Invoke the function

The `timer` function is triggered by the Azure Functions app from a timer. Follow the steps below to verify the output in the queue storage of the function app.

1. In the AWS Portal, click **Storage accounts** to view the created queue.
2. From the list, click on the storage account entry that corresponds with your function app.
3. Click ***Queues***, and click on the **queue3** queue.
4. You view the output below getting logged every 10 seconds.
   `Hello from timer: <CURRENT_TIME>`
