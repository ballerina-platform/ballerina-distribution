# JSON type

`json` type can be explained as a union of simple basic types, `string`, array of `json` and `json` mapping. In technically, `json` type is a union: `()|boolean|int|float|decimal|string|json[]|map<json>`. A `json` value can be converted to and from ballerina straightforwardly except for the choice of the Ballerina numeric type. Ballerina syntax is compatible with JSON and allows null literal to be compatible with JSON.

`json` is `anydata` without `table` and `xml`. `toJson()` recursively converts `anydata` to `json`. Table values are converted to ` json` arrays and `xml` values are converted to strings.

::: code json_type.bal :::

::: out json_type.out :::

## Related links
- [Access JSON elements](https://ballerina.io/learn/by-example/access-json-elements/)
- [Converting to user-defined type](https://ballerina.io/learn/by-example/converting-to-user-defined-type/)
- [Converting from user-defined type to JSON](https://ballerina.io/learn/by-example/converting-from-user-defined-type-to-json/)
- [fromJsonString](https://lib.ballerina.io/ballerina/lang.value/0.0.0/functions#fromJsonString)
- [cloneWithType](https://lib.ballerina.io/ballerina/lang.value/0.0.0/functions#cloneWithType)