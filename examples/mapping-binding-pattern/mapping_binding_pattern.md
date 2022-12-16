# Mapping Binding Pattern

A mapping binding pattern matches a mapping value with its fields. A `record` type will be assigned for the mapping binding pattern if it successfully matches the value. Both `map` and `record` types can be used in mapping binding patterns. Record destructuring in binding patterns can be used to refer to existing variables as a record, destructure the given value on the right-hand side, and assign the values to each individual variable of the record during the runtime. These binding patterns are especially helpful when dealing with queries and useful when destructuring json values.

::: code mapping_binding_pattern.bal :::

::: out mapping_binding_pattern.out :::

## Related links
- [Binding Pattern](/learn/by-example/binding-pattern/)
- [Typed Binding Pattern](/learn/by-example/typed-binding-pattern/)
- [Rest Binding Pattern in Mapping Binding Pattern](/learn/by-example/rest-binding-pattern-in-mapping-binding-pattern/)
