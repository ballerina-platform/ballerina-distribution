# Array/map symmetry

Ballerina provides a fine symmetry between lists and mappings. Lists are indexed by integers and mappings are indexed by strings. In terms of the JSON format, lists are represented by arrays and mappings are represented by objects.

The constructor for lists uses square brackets and the constructor for mappings uses curly brackets. Both list and mappings types can be described in two ways using uniform member types and per-index member types. A list with a uniform  `T` member type is an array declared as `T[]`. A mapping with a uniform `T` type member is a map declared as `map<T>`. Similarly, a list with per-index member types `T0` and `T1` is a tuple, declared as `[T0, T1]`, and a mapping with per-index member types is a record declared as `record { Tx x; Ty y; }`. You can have an open type using the `...` notation. In the case of lists, an open type is declared as a tuple type as `[T0, Tr...]`. In the case of mappings, it is a record type declared as `record {| Tx x; Tr...; |}`.

::: code array_map_symmetry.bal :::

::: out array_map_symmetry.out :::