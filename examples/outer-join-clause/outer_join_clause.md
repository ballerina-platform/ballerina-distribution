# Outer join clause

The `outer join` clause performs a left outer equijoin. This join returns each element of the first collection, regardless of whether it has any matching elements in the second collection. For the values for which there is no matching value on the second collection, the resulting value will contain `nil`.

::: code outer_join_clause.bal :::

::: out outer_join_clause.out :::