# Avro - Data serialization/deserialization

The `avro` module allows serializing and deserializing the subtypes of Ballerina `anydata`. Initially, an `avro:Schema` instance must be created by providing a `string` value representing an Avro schema. The `toAvro()` and `fromAvro()` methods of the `avro` module serialize and deserialize data respectively, using the generated Avro schema.

The `toAvro()` method serializes the given data according to the specified Avro schema. The `fromAvro()` method accepts a `byte[]` argument containing serialized data and binds the deserialized value to the inferred data type determined by the user.

::: code avro_serdes.bal :::

Run the program by executing the following command.

::: out avro_serdes.out :::

## Related links

- [`avro` - API documentation](https://central.ballerina.io/ballerina/avro/)
- [`avro` - Specification](/spec/avro)
