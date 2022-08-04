# Readonly and isolated

`isolated` functions can access `final` variables with `readonly` type without locking. It relies on the fact that
immutability is deep. `isolated` for functions complements `readonly` for data.

::: code readonly_and_isolated.bal :::

::: out readonly_and_isolated.out :::