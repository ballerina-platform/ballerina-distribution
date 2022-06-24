# Nil

Ballerina's version of `null` is called `nil` and written as `()`. 
Ballerina types do not implicitly allow `nil`.
Type `T?` means `T` or `nil`. You can use `==` and `!=` to test whether a value is `nil`: no implicit conversion to
`boolean`.

::: code nil.bal :::

::: out nil.out :::