# Readonly and isolated

`isolated` functions can access `final` variables with `readonly` type without locking. It relies on the fact that
immutability is deep. `isolated` for functions complements `readonly` for data.

::: code ./examples/readonly-and-isolated/readonly_and_isolated.bal :::

::: out ./examples/readonly-and-isolated/readonly_and_isolated.out :::