# YAML to anydata conversion with projection

The `data.yaml` library provides multiple APIs to selectively convert elements and attributes from a YAML source, 
which can be provided as a `string`, `byte array`, or `byte block stream`, into a Ballerina record. 
In projection users can drop attributes and elements in arrays when creating the Ballerina value.

For more information on the underlying module, see the [`data.yaml` module](https://lib.ballerina.io/ballerina/data.yaml/latest/).

::: code yaml_to_anydata_with_projection.bal :::

::: out yaml_to_anydata_with_projection.out :::
