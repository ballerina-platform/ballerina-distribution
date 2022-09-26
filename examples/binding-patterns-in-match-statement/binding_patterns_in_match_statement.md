# Binding patterns in `match` statement

Binding patterns in a match statement can be used for working with a successfully matched value by assigning it to a variable.
You can use the rest binding pattern (...r) in a binding pattern of a `match` statement to bind the fields not explicitly mentioned in the binding pattern. This is particularly useful when working with open records.

::: code binding_patterns_in_match_statement.bal :::

::: out binding_patterns_in_match_statement.out :::