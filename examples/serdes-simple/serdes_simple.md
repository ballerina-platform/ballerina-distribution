# SerDes - Serialization/Deserialization

The `serdes` module helps to serialize and deserialize subtypes of Ballerina `anydata`. The `serdes:Proto3Schema` object takes `typedesc` as an argument when instantiation and maps the Ballerina `anydata` type to a protocol buffer schema. The `serialize` and `deserialize` methods of the `serdes:Proto3Schema` object serializes and deserializes data using the generated protocol buffer schema. The `serialize` method takes the `anydata` value as an argument whereas the `deserialize` method takes `byte[]` as an argument. This example demonstrates how to serialize and deserialize a user-defined `record` type.

::: code serdes_simple.bal :::

Run the program by executing the following command.

::: out serdes_simple.out :::

## Related Links
- [`serdes` - API documentation](https://lib.ballerina.io/ballerina/serdes/latest)
- [`serdes` - Specification](/spec/serdes)
