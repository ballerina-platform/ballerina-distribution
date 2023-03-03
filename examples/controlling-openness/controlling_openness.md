# Controlling openness

Use `record {| ... |}` to describe a record type that allows exclusively what is specified in the body. Use an open record of type `record {| T...; |}`  to allow other fields of type `T`. `map<T>` is the same as `record {| T...; |}`.

::: code controlling_openness.bal :::

::: out controlling_openness.out :::

## Related links
- [Records](/learn/by-example#)
- [Open Records](/learn/by-example/open-records/)
- [Maps](/learn/by-example/maps/)
