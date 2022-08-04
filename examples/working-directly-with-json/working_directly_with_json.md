# Working directly with JSON

Ballerina defines certain types as lax types for which static typing rules are less strict.
For example, field access (`.`) and optional field access (`?.`), which are generally allowed on
records and objects for fields that are defined in the type descriptors, are also additionally
allowed on lax types. For such operations, some of the type checking is moved from compile time to runtime.
`json` is defined to be a lax type along with any `map<T>` where `T` is a lax type.

::: code working_directly_with_json.bal :::

::: out working_directly_with_json.out :::