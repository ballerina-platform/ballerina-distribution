# `json` type

The `json` type can be explained as a union of the simple basic types, `string`, array of `json`, and `json` mapping. Technically, the `json` type is a union: `()|boolean|int|float|decimal|string|json[]|map<json>`. A `json` value can be converted to and from Ballerina straightforwardly except for the choice of the Ballerina numeric type. Ballerina syntax is compatible with JSON and allows null literal to be compatible with JSON.

`json` is `anydata` without `table` and `xml`. `toJson()` recursively converts `anydata` to `json`. Table values are converted to `json` arrays and `xml` values are converted to strings.

::: code json_type.bal :::

::: out json_type.out :::

## Related links
- [Access JSON elements](/learn/by-example/access-json-elements/)
- [Converting from JSON to user defined type with langlib functions](/learn/by-example/converting-from-json-to-user-defined-type-with-langlib-functions/)
- [Converting from user-defined type to JSON](/learn/by-example/converting-from-user-defined-type-to-json/)
- [fromJsonString](https://lib.ballerina.io/ballerina/lang.value/0.0.0/functions#fromJsonString)
- [cloneWithType](https://lib.ballerina.io/ballerina/lang.value/0.0.0/functions#cloneWithType)