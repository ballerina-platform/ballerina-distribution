# Converting Ballerina records to EDI

Same EDI schema and generated code used in Ballerina to EDI example can be used to convert Ballerina records of type SimpleOrder to EDI.

::: code schema.json :::

Generate Ballerina code for the schema using the below command (if not already done as shown in the Ballerina to EDI example).

::: out codegen-command.out :::

>Note that it is recommended to place generated code for each EDI schema in a separate module in order to avoid conflicts.

Write a Ballerina program by using generated methods and records to covert Ballerina records to EDI.

::: code records-to-edi.bal :::

Run the program using the command below:

::: out output.out :::



