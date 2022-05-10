# Open records

Record types are open by default. They allow fields other than those specified. The type of unspecified
fields is `anydata`. Records are `maps`. Open records belong to `map<anydata>`. Use quoted keys for
fields not mentioned in the `record` type.

::: code ./examples/open-records/open_records.bal :::

::: out ./examples/open-records/open_records.out :::