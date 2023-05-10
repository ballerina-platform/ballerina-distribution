# Azure Functions Cosmos DB trigger

This example demonstrates using a Cosmos DB trigger to invoke an AWS Lambda function and a queue output binding to write an entry to a queue.

For more information, see the [Azure Functions deployment guide](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/azure-functions/).

## Set up the prerequisites

Follow the steps below to create a Cosmos DB and a queue to make use of those services later in this example.

1. Set up the [general prerequisites](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/azure-functions/#set-up-the-prerequisites).
2. Create the queue in the [HTTP trigger](/learn/by-example/azure-functions/http-trigger/) example to resue it in this one.
3. Create an [Azure Cosmos DB account](https://portal.azure.com/#create/Microsoft.DocumentDB) and select **Cosmos DB Core**.
4. Once the database is created, go to the **Data Explorer**, and select **Create Container**.
5. Enter `db1` as the Database ID, `c1` as the collection ID, and click **Ok**.
>**Note:** If you want to change these values, change them in the code as well.
6. Go to the **Keys** tab of the Cosmos DB page.
7. Copy the value of the `PRIMARY CONNECTION STRING`.
8. Click the **Configuration** tab on the function app page.
9. Select **New Application Setting**, and paste the data you copied above as the value. 
>**Tip:** For the key, use the value of the `connectionStringSetting` key and save.

Example application settings are as follows.

- Name - `CosmosDBConnection`
- Value - `AccountEndpoint=https://db-cosmos.documents.azure.com:443/;AccountKey=12345asda;`

Now, as all the infrastructure required are up and running and configured, start building and deploying the Azure function.

## Write the function

Follow the steps below to write the function.

1. Execute the command below to create a new Ballerina package.

::: out bal_new.out :::

2. Replace the content of the generated Ballerina file with the content below.

::: code azure-functions-cosmosdb-trigger.bal :::

## Build the function

Execute the command below to generate the Azure Functions artifacts.

::: out bal_build.out :::

## Deploy the function

Execute the Azure CLI command given by the compiler to create and publish the functions by replacing the sample app name given in the command with your respective Azure `<function_app_name>`.

>**Tip:** For instructions on getting the values, see [Set up the prerequisites](https://ballerina.io/learn/run-in-the-cloud/function-as-a-service/azure-functions/#set-up-the-prerequisites).

## Invoke the function

Once the function is deployed, add an item to the collection.

1. Navigate to the collection created in the **Data Explorer**.
2. Click **New Item** to add a new item to the collection.
3. Go to the queue page and observe the added new entry.

>**Info:** Additionally, for debugging purposes, view the logs under the **Logs stream** in the function app.

