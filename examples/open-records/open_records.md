# Open records

A record type that uses either the `{` and `}` delimiters or the `{|` and `|}` delimiters with a rest descriptor is considered open. They allow fields other than those specified. The type of unspecified fields is `anydata`. Open records belong to `map<anydata>`. Quoted keys can be used to specify fields that are not mentioned in the record type.

::: code open_records.bal :::

::: out open_records.out :::

## Related links
- [Records](/learn/by-example/records/)
- [Controlling openness](/learn/by-example/controlling-openness/)
- [Maps](/learn/by-example/maps/)
