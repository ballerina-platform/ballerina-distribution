# Controlling openness

Use `record {| ... |}` to describe a `record` type that allows exclusively what is specified in the body.
Use `T...` to allow other fields of type `T`. `map<T>` is same as `record {| T...; |}`.

::: code controlling_openness.bal :::

::: out controlling_openness.out :::