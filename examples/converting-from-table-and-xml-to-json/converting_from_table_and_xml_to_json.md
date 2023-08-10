# Converting from `table` and `xml` to JSON

`toJson()` recursively converts `anydata` to `json`. Table values are converted to `json` arrays and `xml` values are converted to strings.

::: code converting_from_table_and_xml_to_json.bal :::

::: out converting_from_table_and_xml_to_json.out :::

## Related links
- [JSON type](/learn/by-example/json-type)
- [toJson](https://lib.ballerina.io/ballerina/lang.value/0.0.0#toJson)