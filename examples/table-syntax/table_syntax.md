# Table syntax

A `table` is a collection of records. Each `record` represents a row of the `table`. A `table` is plain data if and only if its rows are plain data. A `table` maintains an invariant that each row is uniquely identified by a key. Each row’s key is stored in fields, which must be immutable.

Compared to maps,

- key is part of the value rather than being separate.
- The type of the key is not restricted to `string`.
- The order of the members is preserved.

A `record` field can be declared as `readonly`. A value cannot be assigned to such a field after the record is created. The `table` type gives the type of the row and the name of the key field. The `table constructor expression` looks like an `array constructor`. The `foreach` statement will iterate over a table's rows in their order. Use `t[k` to access a row using its key.

::: code table_syntax.bal :::

::: out table_syntax.out :::