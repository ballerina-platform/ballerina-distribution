# Match guard in `match` statements

A match-guard is an expression that is used in a `match` clause to determine whether the clause should be executed. A `match` clause will only be executed if its match-guard evaluates to true.

A function call is only allowed with an expression in a match-guard when there is no possibility that it can mutate the value being matched.

::: code match_guard_in_match_statements.bal :::

::: out match_guard_in_match_statements.out :::

## Related links
- [If statement](/learn/by-example/if-statement/)
- [Match statement](/learn/by-example/match-statement/)
