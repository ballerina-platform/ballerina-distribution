# Accessing optional JSON elements

If there is no prior knowledge of the availability of a particular field, optional field access (`?.`) can be used on the `json` value. If the particular field is not available, it will return `nil`.

::: code access_optional_json_elements.bal :::

Run the example as follows.

::: out access_optional_json_elements.out :::

## Related links
- [JSON type](/learn/by-example/json-type/)
- [Check expression](/learn/by-example/check-expression/)
- [Optional fields](/learn/by-example/optional-fields/)
