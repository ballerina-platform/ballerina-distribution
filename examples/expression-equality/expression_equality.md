# Expression equality

In Ballerina, expression equality is determined using two operators: `==` for value equality and `===` for reference equality. The `==` operator checks for deep equality between two values by comparing the actual data they store. In contrast, the `===` operator checks whether two values share the same storage identity, meaning it compares whether the values reference the same memory location. 
Values with storage identity, such as structured types like maps and arrays, are stored as references, so `===` can determine if two references point to the same underlying data. For simple types like, such as integers and booleans, which do not have storage identity, `===` behaves the same as `==`.

::: code expression_equality.bal :::

::: out expression_equality.out :::

## Related links
- [Maps](/learn/by-example/maps)
