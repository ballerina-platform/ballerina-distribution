# Inferring isolated

`isolated` is a complex feature, which would be a lot for an application developer to understand.
A typical Ballerina application consists of a single module that imports multiple library modules.
Within a single module, the compiler infers `isolated` qualifiers. An object without mutable fields is
inherently `isolated`. It is the application developer's responsibility to use `lock` statements where
needed. e.g.,
<ul>
<li>accessing `self` in a `service` object with mutable state</li>
<li>accessing mutable module-level variables</li>
</ul>
<br></br>
<p>Compiler can inform developer where missing locks are preventing a `service` object or method from
being `isolated`.</p>

::: code inferring_isolated.bal :::

::: out inferring_isolated.out :::