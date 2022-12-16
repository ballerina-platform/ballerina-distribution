# SerDes - Serialization/Deserialization

The `serdes` module allows serializing and deserializing the subtypes of Ballerina `anydata`. The `serdes:Proto3Schema` object takes `typedesc` as an argument when instantiating, and maps the given type to a Protocol Buffer schema. The `serialize` and `deserialize` methods of the `serdes:Proto3Schema` object serialize and deserialize data using the generated Protocol Buffer schema. The `serialize` method takes a value of the given type as an argument whereas the `deserialize` method takes `byte[]` as an argument and tries to bind the deserialized value to the `typedesc` inferred from the contextually-expected type.

::: code serdes_simple.bal :::

Run the program by executing the following command.

::: out serdes_simple.out :::

## Related links
- [`serdes` - API documentation](https://lib.ballerina.io/ballerina/serdes/latest)
- [`serdes` - Specification](/spec/serdes)
