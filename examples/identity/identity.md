# Identity

`===` and `!==` operators test for identity. Values of mutable basic types are identical if and only if they are stored in the same address.
`==` and `!=` are not defined for objects. `-0.0` and `+0.0` are equal but not identical.

::: code identity.bal :::

::: out identity.out :::