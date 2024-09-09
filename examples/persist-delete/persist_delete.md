# Persist write - Delete record

The bal persist feature provides support to manage data persistence in a Ballerina package. It starts with defining the application's data model. Once the model is defined, the client API is generated with resources based on the model. The generated API can be used to query and manipulate the persistent data in the application.
The generated client API provides a `delete` resource method to delete records from the data store.

> **Note:** This example uses the Ballerina tables as the data store. For more information about other supported data stores, see [Supported Data Stores](/learn/supported-data-stores/).

#### Initialize the project
Execute the command below to initialize `bal persist` in the project.

::: out persist_init.out :::

#### Model the data
Add `Employee` entity with the following fields in the `model.bal` file inside the `persist` directory.

::: code persist_model.bal :::

#### Generate client APIs
Execute the command below to generate the Ballerina client API.

::: out persist_generate.out :::

> **Note:** The `bal persist generate` command is a one-time generation task, and the generated client code is a part of the project. We can also integrate the client code generation with the project's build process by executing the `bal persist add` command. This command will add the client code generation as a build task in the `Ballerina.toml` file. See [Persist CLI Commands](learn/persist-cli-tool/) for more information.


#### Use the generated client API
Using the generated client API, you can delete records from the data store with the `delete` resource method.

::: code persist_delete.bal :::

#### Run the program
Execute the command below to run the program.

::: out persist_delete.out :::
