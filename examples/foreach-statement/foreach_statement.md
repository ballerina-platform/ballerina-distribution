# Foreach statement

The `foreach` statement iterates over an `iterable` value such as arrays, tuples, maps, records, string, and tables etc. by executing a block of statements for each value in iteration order. For a string value, it will iterate over each code point of the string.

The syntax contains a variable, keyword `in` followed by an expression and a block of statements. The variable can be in the form of a type binding pattern and the expression can be an action invocation, which should evaluate to an iterable value.

::: code foreach_statement.bal :::

::: out foreach_statement.out :::

## Related links
- [Continue statement](/learn/by-example/continue-statement/)
- [While statement](/learn/by-example/while-statement/)
- [Break statement](/learn/by-example/break-statement/)
