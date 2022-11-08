# Binding patterns in the `match` statement

Binding patterns can be used in a match statement to bind parts of a successful match to variables.
You can use the rest binding pattern (`...r`) in a binding pattern of a `match` statement to bind the fields that are not explicitly bound in the binding pattern. This is particularly useful when working with open records.

::: code binding_patterns_in_match_statement.bal :::

::: out binding_patterns_in_match_statement.out :::