# Isolated functions

A call to an `isolated` function is concurrency-safe if it is called with arguments
that are safe at least until the call returns. <br></br>
A function defined as `isolated`:
<ul>
<li>has access to mutable state only through its parameters</li>
<li>has unrestricted access to immutable state</li>
<li>can only call functions that are `isolated`</li>
</ul>
<br></br>
<p>Constraints are enforced at compile-time. `isolated` is a part of the function type.
Weaker concept than pure function.</p>

::: code isolated_functions.bal :::

::: out isolated_functions.out :::