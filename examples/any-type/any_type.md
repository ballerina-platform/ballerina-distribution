# Any type

`any` means any value except an `error` value.
Equivalent to a union of all non-error basic types.
Use `any|error` for absolutely any value.
The `lang.value` lang library contains functions that apply to multiple basic types.

::: code ./examples/any-type/any_type.bal :::

::: out ./examples/any-type/any_type.out :::