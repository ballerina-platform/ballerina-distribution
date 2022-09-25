# Built-in integer subtypes

Ballerina has one integer type (`int`), which is a 64-bit, signed type. 

The `ballerina/lang.int` lang library defines the following built-in subtypes of this `int` type.

- `int:Signed32`
- `int:Unsigned32`
- `int:Signed16`
- `int:Unsigned16`
- `int:Signed8`
- `int:Unsigned8` (same as `byte`)

The runtime behavior of operations on these subtypes are the same as for the `int` type. Bitwise operations with operands of these types have special typing, which allows using a more specific type for the operation.

Integer subtypes are useful for interfacing with external systems that use these types. They also allow implementations to optimize storage, particularly for arrays.

::: code built_in_integer_subtypes.bal :::

::: out built_in_integer_subtypes.out :::
