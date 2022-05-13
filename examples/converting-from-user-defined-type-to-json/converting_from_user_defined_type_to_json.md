# Converting from user-defined type to JSON

Conversion from `json` value to JSON format is straightforward.
Converting from application-specific, user-defined subtype of `anydata`
to `json` is also possible.
In many cases, this is a no-op: user-defined type will be a subtype of
`json` as well as of `anydata`.
With tables, XML or records open to `anydata`, use `toJson()` to convert
`anydata` to `json`.
APIs that generate JSON typically accept `anydata` and automatically 
apply `toJson()`.

::: code ./examples/converting-from-user-defined-type-to-json/converting_from_user_defined_type_to_json.bal :::

::: out ./examples/converting-from-user-defined-type-to-json/converting_from_user_defined_type_to_json.out :::