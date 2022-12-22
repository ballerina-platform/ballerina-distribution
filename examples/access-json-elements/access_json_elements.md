# Access JSON elements

Ballerina defines certain types as lax types for which static typing rules are less strict. `json` is defined to be a lax type along with any `map<T>` where `T` is a lax type.
For example, field access (`.`) and optional field access (`?.`), which are generally allowed on records and objects for fields that are defined in the type descriptors, are also allowed additionally on lax types. For such operations, some of the type checkings are moved from compile time to runtime.
The best way of accessing JSON elements is to convert the `json` value to a user-defined type.

`check Expr` is treated as `check val:ensureType(Expr, s)` when Expr is subtype of json and expected type is a subtype of `()|boolean|int|float|decimal|string`. `s` is a typedesc value representing expected type.

::: code working_directly_with_json.bal :::

Run the example as follows.

::: out working_directly_with_json.out :::

## Related links
- [JSON type](https://ballerina.io/learn/by-example/json-type)
- [Check expression](https://ballerina.io/learn/by-example/check-expression)
- [ensureType function](https://ballerina.io/learn/by-example/ensureType-function)