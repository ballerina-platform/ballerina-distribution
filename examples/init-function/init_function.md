# Init function

The `init` function will be executed as the last function called in the program initialization phase. Uninitialized module level `final` or `non-final` variables can be initialized in this function.

The `init` function must not be declared as public. Its return type must be a subtype of `error?` or `()`. It must have no parameters.

::: code init_function.bal :::

::: out init_function.out :::

## Related links
- [Functions](/learn/by-example/functions/)
