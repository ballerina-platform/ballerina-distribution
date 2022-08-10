# Transactional qualifier

At compile-time, regions of code are typed as being a transactional context.
Ballerina guarantees that, whenever that region is executed, there will be a current transaction.
A function with a `transactional` qualifier can only be called from a transactional context; function  body will be a transactional context.
`transactional` is also a boolean expression that tests at runtime whether there is a current transaction: used in a condition results in a transactional context.

::: code transactional_qualifier.bal :::

::: out transactional_qualifier.out :::