# Converting EDI data to Ballerina records

EDI is a widely used message format for business-to-business (B2B) communications. Ballerina simplifies working with EDI data by converting them to Ballerina records, so that all Ballerina records related operations can be applied on EDI data as well (e.g. transforming EDI data, writing EDI data to data bases, transering EDI data over various network protocols, etc).

First, it is necessary to write a schema for the EDI data type that needs to be processed. Below is a simple EDI schema for sales orders data. According to the schema, data must begin with a `HDR` segment followed by zero or more `ITM` segments. HDR segment contains four fields: code, orderId, organization and date. ITM segment has three fields: code, item and quantity.

::: code schema.json :::

Below is an example EDI text that can be parsed using the above schema.

::: code order1.edi :::

Run the below command to generate the Ballerina parser for the above schema.

::: out codegen-command.out :::

>Note that it is recommended to place generated code for each EDI schema in a separate module in order to avoid conflicts.

Write a Ballerina program by using generated methods and records to work with EDI data.

::: code edi-to-record.bal :::

Run the program using the command below:

::: out output.out :::



