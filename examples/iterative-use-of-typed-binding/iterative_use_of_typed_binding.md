# Iterative use of typed binding patterns

The iterative use is always followed by the `in` keyword. In this approach, an iterator gets created as a result of evaluating an expression, and the typed binding pattern is matched against each value returned by the iterator. The `in` keyword can be used with the `foreach` statement, `from` clause, and `join` clause in query expressions, and with the `let` expression.

::: code iterative_use_of_typed_binding.bal :::

::: out iterative_use_of_typed_binding.out :::

## Related links
- [Binding patterns](/learn/by-example/binding-patterns/)
- [Typed binding pattern](/learn/by-example/typed-binding-pattern/)
- [Single use of typed binding patterns](/learn/by-example/single-use-of-typed-binding/)
- [Query expressions](/learn/by-example/query-expressions/)
- [Foreach statement](/learn/by-example/foreach-statement/)
