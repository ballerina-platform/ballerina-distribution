# Converting from user-defined type to JSON

Conversion of a `json` value to JSON format is straightforward. Converting from an application-specific, user-defined subtype of `anydata` to `json` is also possible.

In many cases, conversion happens automatically. when user-defined type is a subtype of JSON as well as of `anydata`. With tables, XML or records open to `anydata`, use `toJson()` to convert `anydata` to `json`. APIs that generate JSON typically accept `anydata` and automatically apply `toJson()`.

::: code converting_from_user_defined_type_to_json.bal :::

::: out converting_from_user_defined_type_to_json.out :::

## Related links
- [JSON type](https://ballerina.io/learn/by-example/json-type/)
- [Open records](https://ballerina.io/learn/by-example/open-records/)
- [Control openess](https://ballerina.io/learn/by-example/controlling-openness)