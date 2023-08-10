# Records

A `record` type is a collection of specific named fields where each field has a type for its value. A field `f` of a record value `r` can be accessed with `r.f`. Records are mutable and can be constructed using a syntax similar to a map.

A `closed record` type only allows fields that are specified whereas, an `open record` type allows additional fields other than those specified. Typically, a `record` type is written using a type definition.

::: code records.bal :::

::: out records.out :::

## Related links
- [Open records](/learn/by-example/open-records/)
- [Controlling openness](/learn/by-example/controlling-openness/)
- [Default values for record fields](/learn/by-example/default-values-for-record-fields/)
- [Maps](/learn/by-example/maps/)
