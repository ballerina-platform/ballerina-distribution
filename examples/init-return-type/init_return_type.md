# Init return type

`init` function has a return type, which must be a subtype of `error?`. If `init` returns `()`, then `new` expression returns the newly constructed `object` to the caller. If `init` returns an `error`, then `new` expression also returns the same `error` to the caller. If `init` does not specify a return type, then the return type defaults to `()` as usual, meaning that `new` will never return an `error`.

::: code init_return_type.bal :::

::: out init_return_type.out :::