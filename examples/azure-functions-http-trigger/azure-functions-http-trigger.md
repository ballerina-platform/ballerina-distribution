# Azure Functions- HTTP trigger

Azure Functions is an event driven, serverless computing platform. Azure Functions can be written from Ballerina using the listeners and services provided by Azure Functions package. You can view the code examples below.

For more information, see the [Azure deployment guide](/learn/run-in-the-cloud/function-as-a-service/azure-functions/).

::: code azure-functions-http-trigger.bal :::

Create a Ballerina package and replace the content of the generated BAL file with the content above.
::: out bal_new.out :::

Build the Ballerina program to generate the Azure Functions artifacts.
::: out bal_build.out :::

Execute the Azure CLI command given by the compiler to publish the functions (replace the sample app name given in the command with your respective Azure `<function_app_name>`).
::: out az_deploy.out :::

Invoke the `HTTP Trigger` functions.
::: out execute_function.out :::

The `timer` function is triggered by the Azure Functions app from a timer. You can check the queue storage to see the output. For more information on the infrastructure, see [Azure Functions deployment](/learn/run-in-the-cloud/function-as-a-service/azure-functions/).
