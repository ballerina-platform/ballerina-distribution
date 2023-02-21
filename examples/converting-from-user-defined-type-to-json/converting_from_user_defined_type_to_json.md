# Convert from user-defined type to JSON

Conversion of a `json` value to JSON format is straightforward. Converting from an application-specific, user-defined subtype of `anydata` to `json` is also possible.

In many cases, the conversion happens automatically when the user-defined type is a subtype of JSON as well as of `anydata`. With tables, XML or records that are open to `anydata` use `toJson()` to convert `anydata` to `json`. APIs that generate JSON typically accept `anydata` and automatically apply `toJson()`.

::: code converting_from_user_defined_type_to_json.bal :::

::: out converting_from_user_defined_type_to_json.out :::

## Related links
- [JSON type](/learn/by-example/json-type/)
- [Open records](/learn/by-example/open-records/)
- [Controlling openess](/learn/by-example/controlling-openness)