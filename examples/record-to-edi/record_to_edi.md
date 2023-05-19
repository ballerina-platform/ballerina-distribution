# Record to EDI conversion

Same EDI schema and generated code used in EDI to record conversion example can be used to convert Ballerina records of type SimpleOrder to EDI.

::: code schema.json :::

Create a new Ballerina project named `record_to_edi` and create a module named `sorder` inside that project by using the below commands.

::: code bal_project.out :::

Create a new folder named `resources` in the root of the project and copy the schema file into it. At this point, directory structure of the project would look like below:

::: package_stricture.out :::

Run the below command from the project root directory to generate the Ballerina parser for the above schema.

::: out codegen_command.out :::

>Note that it is recommended to place generated code for each EDI schema in a separate module in order to avoid conflicts.

Write a Ballerina program by using generated methods and records to convert Ballerina records to EDI.

::: code record_to_edi.bal :::

Run the program using the command below:

::: out output.out :::
