# Isolated variables

When a variable is declared as `isolated`, the compiler guarantees that it is an `isolated` root and accessed only within a `lock` statement. An isolated variable declaration must be a non-public module-level variable declaration initialized with an `isolated` expression. A `lock` statement that accesses an `isolated` variable must maintain `isolated` root invariant:

- access only one `isolated` variable
- call only `isolated` functions
- transfers of values in and out must use `isolated` expressions

The `isolated` functions are allowed to access `isolated` module-level variables, provided they follow the above rules.

::: code isolated_variables.bal :::

Executing the above code gives the output below.

::: out isolated_variables.out :::