# EDI to record conversion

EDI is a widely used message format for business-to-business (B2B) communications. Ballerina simplifies working with EDI data by converting them to Ballerina records, so that all operations related to Ballerina records can be applied on EDI data as well (e.g. transforming EDI data, writing EDI data to databases, transering EDI data over various network protocols, etc.).

First, it is necessary to write a schema for the EDI data type that needs to be processed. Below is a simple EDI schema for sales order data. According to the schema, data must begin with a `HDR` segment followed by zero or more `ITM` segments. `HDR` segment contains four fields: `code`, `orderId`, `organization`, and `date`. `ITM` segment has three fields: `code`, `item`, and `quantity`.

::: code schema.json :::

Below is an example EDI text that can be parsed using the above schema.

::: code order.edi :::

Create a new Ballerina project named `edi_to_record` and create a module named `sorder` inside that project by using the below commands.

::: code bal_project.out :::

Create a new folder named `resources` in the root of the project and copy the schema file into it. At this point, directory structure of the project would look like below:

::: package_stricture.out :::

Run the below command from the project root directory to generate the Ballerina parser for the above schema.

::: out codegen_command.out :::

>Note that it is recommended to place generated code for each EDI schema in a separate module in order to avoid conflicts.

Write a Ballerina program by using generated methods and records to work with EDI data.

::: code edi_to_record.bal :::

Run the program using the command below:

::: out output.out :::
