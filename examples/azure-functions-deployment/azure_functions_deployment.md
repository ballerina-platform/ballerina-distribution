# Azure Functions

Azure Functions is an event driven, serverless computing platform. Ballerina functions can be deployed in Azure Functions by annotating a Ballerina function with Azure functions annotation. 

The Trigger, Input and Output bindings parameter annotations were introduced as per the Azure functions programming model. More information can be found on [Azure Deployment Guide](/learn/deployment/azure-functions/).

::: code azure_functions_deployment.bal :::

Create a ballerina package and replace the contents of the generated bal file with the contents above.
::: out bal_new.out :::

Build the Ballerina program to generate the Azure Functions artifacts
::: out bal_build.out :::

Execute the Azure CLI command given by the compiler to publish the functions (replace with your respective Azure <resource_group> and <function_app_name>)
::: out az_deploy.out :::

Invoke the HTTP Trigger functions
::: out execute_function.out :::

The `queuePopulationTimer` function is being triggered from the Azure Function App from a timer. You can check the 
queue storage to see the output. Details on infrastructure can be found on the [Azure Deployment Guide](/learn/deployment/azure-functions/)
