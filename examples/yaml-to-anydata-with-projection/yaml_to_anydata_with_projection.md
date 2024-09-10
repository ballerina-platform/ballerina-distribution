# YAML to anydata conversion with projection

The `data.yaml` library provides multiple APIs to selectively parse elements and attributes from a YAML source, in the form of a string, byte array, or byte block stream, into a Ballerina record. Using projection, users can selectively add fields to records and limit the sizes of arrays.

In this example, the `password` attribute is excluded when creating the `DatabaseConfig` record, and only the first two elements from the source are used to create the `remotePorts` array.

For more information on the underlying module, see the [`data.yaml` module](https://lib.ballerina.io/ballerina/data.yaml/latest/).

::: code yaml_to_anydata_with_projection.bal :::

::: out yaml_to_anydata_with_projection.out :::

## Related links
- [Binary Data](/learn/by-example/binary-data/)