# EDI to record conversion

EDI is a widely used message format for business-to-business (B2B) communications. Ballerina simplifies working with EDI data by converting it to Ballerina records, so that all operations related to Ballerina records can be applied on EDI data as well (e.g. transforming EDI data, writing EDI data to databases, transferring EDI data over various network protocols, etc.).

For the standard UN/EDIFACT D03A message types there is nothing to write and nothing to generate: import the prebuilt package for the relevant business domain from the `ballerinax` organization and call its `fromEdiString` function. Here the `mORDERS` submodule of `ballerinax/edifact.d03a.supplychain` carries the D03A `ORDERS` schema and the records generated from it.

Envelope segments are skipped, so `fromEdiString` accepts a bare message as well as a full interchange. Segments that repeat, such as `RFF` and `NAD`, become segment groups on the record.

::: code edi_to_record.bal :::

Run the program using the command below.

::: out output.out :::

When a trading partner deviates from the published specification — an extra element, a different code list, a segment the standard marks optional but the partner always sends — convert that specification into a Ballerina EDI schema, edit the schema, and generate a module from it with the `bal edi` tool instead of using the prebuilt package. See [Changing the specification for a trading partner](https://ballerina.io/learn/edi-tool/#changing-the-specification-for-a-trading-partner) for the steps.
