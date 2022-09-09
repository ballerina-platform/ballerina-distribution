# Combining isolated functions and lock

Combining `isolated` functions and `lock` allows `isolated` functions to use `lock` to access mutable module-level state. Key concept is `isolated` root. A value `r` is an `isolated` root if mutable state reachable from `r` cannot be reached from outside except through `r`. 

An expression is an `isolated` expression if it follows rules that guarantee that its value will be an `isolated` root. E.g.,

- an expression with a type that is a subtype of `readonly` is always `isolated`
- an expression `[E1, E2]` is isolated if `E1` and `E2` are `isolated`
- an expression `f(E1, E2)` is `isolated` if `E1` and `E1` are `isolated`, and the type of `f` is an `isolated` function.

::: code combining_isolated_functions_and_lock.bal :::

Executing the above code changes the value of `V` to 200 as shown below.

::: out combining_isolated_functions_and_lock.out :::