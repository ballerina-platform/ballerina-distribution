# Azure Functions- HTTP trigger

The following Ballerina code gives an example of using an HTTP trigger to invoke the function and uses multiple output bindings to return the HTTP response and queue output binding to write an entry to a queue.

First, create a queue to hold the outputs of the function by accessing the storage account that was created alongside the function app in the prerequisites. Select Queues in the sidebar in the storage accounts. Click the Add queue button, and enter the same value as the value of the queueName property in the below QueueOutput annotation.

For more information, see the [Azure Functions deployment guide](/learn/run-in-the-cloud/function-as-a-service/azure-functions/).

::: code azure-functions-http-trigger.bal :::

Create a Ballerina package and replace the content of the generated BAL file with the content above.
::: out bal_new.out :::

Build the Ballerina program to generate the Azure Functions artifacts.
::: out bal_build.out :::

Execute the Azure CLI command given by the compiler to publish the functions (replace the sample app name given in the command with your respective Azure `<function_app_name>`).
::: out az_deploy.out :::

Invoke the `HTTP Trigger` functions.
::: out execute_function.out :::

Refresh the queue page in the portal and view the added entry.
