# Azure Functions

Azure Functions is an event driven, serverless computing platform. Ballerina functions can be deployed in Azure Functions by annotating a Ballerina function with Azure functions annotation". You can view the code examples below.

For more information, see the [Azure deployment guide](/learn/run-in-the-cloud/function-as-a-service/azure-functions/).

::: code azure_functions_deployment.bal :::

Create a Ballerina package and replace the content of the generated BAL file with the content above.
::: out bal_new.out :::

Build the Ballerina program to generate the Azure Functions artifacts.
::: out bal_build.out :::

Execute the Azure CLI command given by the compiler to publish the functions (replace with your respective Azure `<resource_group>` and `<function_app_name>`).
::: out az_deploy.out :::

Invoke the `HTTP Trigger` functions.
::: out execute_function.out :::

The `queuePopulationTimer` function is being triggered by the Azure Function App from a timer. You can check the  queue storage to see the output. For more information on the infrastructure, see [Azure Functions deployment](/learn/run-in-the-cloud/function-as-a-service/azure-functions/).
