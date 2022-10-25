# Outer join clause

The `outer join` clause performs a `left outer equijoin`. This join returns all the values on the left side of the join and matches the values on the right side of the join. For the values for which there is no matching value on the right side, the resulting value will contain `nil`. 

::: code outer_join_clause.bal :::

::: out outer_join_clause.out :::