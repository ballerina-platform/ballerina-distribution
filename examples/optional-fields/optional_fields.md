# Optional fields

Fields of a `record` type can be marked as optional. These fields can be omitted when creating a value of the record type. A field `f` of record type `r` can be accessed via optional field access (e.g., `r?.f`) or member access (e.g., `r["f"]`), which will both return `()` if the field is not present in the record value.

A record that contains optional fields can be destructured. If the optional field is not available, the type of the variable becomes `nil`. The optional field value can also be removed from the record by assigning `()` to the optional field.

::: code optional_fields.bal :::

::: out optional_fields.out :::

## Related links
- [Records](/learn/by-example#)