# Persist read - Filtering and sorting

The Ballerina persistence feature provide support to manage data persistence in a Ballerina package. It starts with defining the application's data model. Once model is defined, the client API is generated with resources based on the model. The generated
API can be used to query and manipulate the persistent data in the application.
The generated client API provides `get` resource function to retrieve all records from the data store. As the `get` resource function returns a stream of records, we can use query expressions to do additional filter. For more information, see [Query Expressions](/learn/by-example/query-expressions/).

> **Note:** This example uses the Ballerina tables as the data store. You can MySQL and Google Sheets as the data store as well. For more information, see [Supported Data Stores](/learn/by-example/persist-supported-data-stores/).

#### Initialize the project
Execute the command below to initialize persistence in the project.

::: out persist_init.out :::

#### Model the data

Add `Employee` entity with the following fields in the `model.bal` file inside the `persist` directory.

::: code persist_model.bal :::

#### Generate client APIs
Execute the command below to generate the Ballerina client API.

::: out persist_generate.out :::

#### Use the generated client API

Using the generated client API, we can retrieve all records from the datastore. The `get` resource function returns a stream of records. We can iterate through the stream and print the records.

::: code persist_filtering.bal :::

#### Run the program

Execute the command below to run the program.

::: out persist_filtering.out :::
