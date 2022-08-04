# Match statement with maps

Match statement can be used to match maps.
Patterns on the left hand side in a match statement can have variable
parts that can be captured.
Useful for working directly with `json`.
Match semantics are open (may have fields other than those specified in the pattern).

::: code match_statement_with_maps.bal :::

::: out match_statement_with_maps.out :::