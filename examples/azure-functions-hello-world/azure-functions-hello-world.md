# Azure Functions - Hello world

This example demonstrates how to expose a simple echo function in Azure Functions.

For more information, see the [Azure deployment guide](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/azure-functions/).

## Set up the prerequisites

For instructions, see [Set up the prerequisites](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/azure-functions/#set-up-the-prerequisites).

## Write the function

Follow the steps below to write the function.

1. Execute the command below to create a new Ballerina package.

::: out bal_new.out :::

2. Replace the content of the generated Ballerina file with the content below.

>**Info:** In the code sample shown above, it has an empty service path and resource path named `hello`. The accessor is `get`. It expects a request with a query parameter for the field `name`. The required artifact generation and data binding will be handled by the `ballerinax/azure_functions` package automatically.

::: code azure-functions-hello-world.bal :::

## Build the function

Execute the command below to generate the Azure Functions artifacts.

::: out bal_build.out :::

## Deploy the function

Execute the Azure CLI command given by the compiler to create and publish the functions by replacing the sample app name given in the command with your respective Azure `<function_app_name>`.

>**Tip:** For instructions on getting the values, see [Set up the prerequisites](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/azure-functions/#set-up-the-prerequisites).

::: out az_deploy.out :::

## Invoke the function

Execute the commands below to invoke the function.

::: out execute_function.out :::
