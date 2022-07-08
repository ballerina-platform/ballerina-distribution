# JSON numbers

Ballerina has three numeric types; but JSON has one.
The `json` type allows `int|float|decimal`.
`toJsonString()` will convert `int|float|decimal` into JSON numeric syntax.
`fromJsonString()` converts JSON numeric syntax into `int`, if possible, and
otherwise `decimal`.
`cloneWithType()` or `ensureType()` will convert from `int` or `decimal` into user's
chosen numeric type.
Net result is that you can use `json` to exchange full range of all three Ballerina
numeric types.
`-0` is an edge case: represented as `float`.

::: code json_numbers.bal :::

::: out json_numbers.out :::