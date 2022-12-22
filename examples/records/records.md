# Records

A `record` type `r` is a collection of specific named fields where each field has a type for its value. A field `f` can be accessed with `r.f`. Records are mutable and can be constructed using a syntax similar to a map. 

Typically, a `record` type is combined with a type definition. A `closed record` type only allows fields that are specified whereas, an `open record` type allows additional fields other than those specified. Record equality works the same as map equality; two records are equal if they have the same set of fields and the values for each field are equal.

::: code records.bal :::

::: out records.out :::

## Related links
- [Open records](/learn/by-example/open-records/)
- [Control openness](/learn/by-example/control-openness/)
- [Default values for record fielts](/learn/by-example/default-values-for-record-fields/)
- [Maps](/learn/by-example/maps/)
