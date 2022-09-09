# Isolated functions

A call to an `isolated` function is concurrency-safe if it is called with arguments that are safe at least until the call returns. 

A function defined as `isolated`:

- has access to mutable state only through its parameters
- has unrestricted access to immutable state
- can only call functions that are `isolated`

Constraints are enforced at compile-time. `isolated` is a part of the function type. Weaker concept than pure function.

::: code isolated_functions.bal :::

By executing the above code, it can be seen that the value of `v` is changed to 100 by calling `set` function.

::: out isolated_functions.out :::