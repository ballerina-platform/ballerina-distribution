# Rest Binding Pattern in Error Binding Pattern

You can use the rest binding pattern (`...r`) to bind the detail mappings that are not explicitly bound in the error binding pattern. The type of the rest binding will be a `map` holding the fields that have not been matched.

::: code rest_binding_pattern_in_error_binding_pattern.bal :::

::: out rest_binding_pattern_in_error_binding_pattern.out :::

## Related links
- [Binding Pattern](/learn/by-example/binding-pattern/)
- [Typed Binding Pattern](/learn/by-example/typed-binding-pattern/)
- [Error Binding Pattern](/learn/by-example/error-binding-pattern/)
