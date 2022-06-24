# Optional fields

Fields of a `record` type can be marked as optional. These fields can be omitted when creating a value of the `record` type.
Such fields can be accessed via optional field access (e.g., `p?.name`) or member access (e.g., `p["name"]`),
which will both return `()` if the field is not present in the `record` value.

::: code optional_fields.bal :::

::: out optional_fields.out :::