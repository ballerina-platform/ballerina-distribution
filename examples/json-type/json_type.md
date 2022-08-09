# JSON type

`json` type is a union: `()|boolean|int|float|decimal|string|json[]|map<json>`. A `json` value can
be converted to and from the JSON format straightforwardly except for the choice of the Ballerina numeric type.
Ballerina syntax is compatible with `JSON` and allows `null` for `()` for JSON compatibility.
`json` is `anydata` without `table` and `xml`. `toJson` recursively converts `anydata` to `json`.
`table` values are converted to `arrays`. `xml` values are converted to `strings`.`json` and `xml`
types are not parallel.

::: code json_type.bal :::

::: out json_type.out :::