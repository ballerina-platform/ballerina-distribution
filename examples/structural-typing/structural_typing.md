# Structural typing

Typing in Ballerina is structural: a type describes a set of values. Ballerina has semantic subtyping:
subtype means subset. Universe of values is partitioned into basic types. Each value belongs to
exactly one basic type. You can think of each value as being tagged with its basic type.
There is a complexity in making structural typing work with mutation. <br/><br/>
Immutable basic types (so far): `nil`, `boolean`, `int`, `float`, `string` <br/><br/>
Mutable basic types (so far): `array`, `map`, and `record`

::: code structural_typing.bal :::

::: out structural_typing.out :::