# Persist read - Select fields

The Ballerina persistence feature provide support to manage data persistence in a Ballerina package. It starts with defining the application's data model. Once model is defined, the client API is generated with resources based on the model. The generated
API can be used to query and manipulate the persistent data in the application.
The generated client API provides support to select subset of fields of the entity when retrieving the records/record from `get` resource function from the data store.

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

Using the generated client API, you can retrieve the record with selected fields from the datastore with both `get` and `get by key` resource functions.

::: code persist_select_fields.bal :::

#### Run the program

Execute the command below to run the program.

::: out persist_select_fields.out :::
