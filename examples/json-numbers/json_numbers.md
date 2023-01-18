# JSON numbers

Ballerina has three numeric types; but JSON has one. The `json` type allows `int|float|decimal`. `toJsonString()` will convert `int|float|decimal` into JSON numeric syntax. `fromJsonString()` converts JSON numeric syntax into `int`, if possible, and otherwise `decimal`.

`cloneWithType()` or `ensureType()` will convert from `int` or `decimal` into the user's chosen numeric type. The net result is that you can use JSON to exchange the full range of all three Ballerina numeric types. `-0` is an edge case: it is represented as a `float`.

## Related links
- [Casting JSON to user-defined type](/learn/by-example/casting-json-to-user-defined-type/)
- [Converting to user-defined type](/learn/by-example/converting-to-user-defined-type/)
- [JSON type](/learn/by-example/json-type/)

::: code json_numbers.bal :::

::: out json_numbers.out :::