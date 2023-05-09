# Azure Functions Cosmos DB trigger

The following Ballerina code gives an example of using a Cosmos DB trigger to invoke the function and a queue output binding to write an entry to a queue.

Before writing and deploying the code, create a Cosmos DB and a queue to make use of those services later.
1. You can reuse the queue you created in the above [`HTTP trigger` -> `Queue output`](/learn/by-example/azure-functions/http-trigger/) example.
2. Create an [Azure Cosmos DB account](https://portal.azure.com/#create/Microsoft.DocumentDB) and select Cosmos DB Core.
3. Once the database is created, go to the **Data Explorer**, and select **Create Container**.
4. Enter `db1` as Database ID and `c1` as the collection ID, and click **Ok**.

**Note:** If you want to change these values, make sure to change them in the code as well.
5. Go to the **Keys** tab of the Cosmos DB page.
6. Copy the value of the `PRIMARY CONNECTION STRING`.
7. Click the **Configuration** tab on the Function app page.
8. Select **New Application Setting**, and paste the data you copied above as the value. For the key, use the value of the `connectionStringSetting` key and save.

Example application setting is as follows.
```
Name - `CosmosDBConnection`
Value - `AccountEndpoint=https://db-cosmos.documents.azure.com:443/;AccountKey=12345asda;`
```

For more information, see the [Azure deployment guide](/learn/run-in-the-cloud/function-as-a-service/azure-functions/).

Now, as all the infrastructure required are up and running and configured, start building and deploying the Azure function.

::: code azure-functions-cosmosdb-trigger.bal :::

Create a Ballerina package and replace the content of the generated BAL file with the content above.
::: out bal_new.out :::

Build the Ballerina program to generate the Azure Functions artifacts.
::: out bal_build.out :::

Execute the Azure CLI command given by the compiler to publish the functions (replace the sample app name given in the command with your respective Azure `<function_app_name>`).
::: out az_deploy.out :::

Once the function is deployed, add an item to the collection.
1. Navigate to the collection created in the **Data Explorer**.
2. Click **New Item** to add a new item to the collection.
3. Go to the queue page and observe the added new entry.

>**Info:** Additionally, for debugging purposes, view the logs under the **Logs stream** in the function app.

