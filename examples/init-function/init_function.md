# Init function

The `init` function will be executed as the last function called in the program initialization phase. Uninitialized module level `final` or `non-final` variables can be initialized in this function.

The `init` function does not accept arguments but it returns `error` or `nil`.

::: code init_function.bal :::

::: out init_function.out :::

## Related links
- [Functions](/learn/by-example/functions/)
