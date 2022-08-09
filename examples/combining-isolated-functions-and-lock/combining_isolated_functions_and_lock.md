# Combining isolated functions and lock

Combining `isolated` functions and `lock` allows `isolated` functions to use
`lock` to access mutable module-level state.
Key concept is `isolated` root. A value `r` is an `isolated` root if mutable state reachable
from `r` cannot be reached from outside except through `r`. An expression is an
`isolated` expression if it follows rules that guarantee that its value will be an
`isolated` root. e.g.,
<ul>
<li>an expression with a type that is a subtype of `readonly` is always `isolated`</li>
<li>an expression `[E1, E2]` is isolated if `E1` and `E2` are `isolated`</li>
<li>an expression `f(E1, E2)` is `isolated` if `E1` and `E1` are `isolated`, and
the type of `f` is an `isolated` function.</li>
</ul>

::: code combining_isolated_functions_and_lock.bal :::

::: out combining_isolated_functions_and_lock.out :::