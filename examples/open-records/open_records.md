# Open records

A record type that uses either the `{` and `}` delimiters or the `{|` and `|}` delimiters with a rest descriptor is considered open. Open records allow fields other than those explicitly specified. 

When the record is open due to using the  `{` and `}` delimiters, the expected type for any additional field is `anydata`. Such records belong to `map<anydata>`. 

Quoted keys can be used to specify fields that are not explicitly specified in an open record type.

::: code open_records.bal :::

::: out open_records.out :::

## Related links
- [Records](/learn/by-example/records/)
- [Controlling openness](/learn/by-example/controlling-openness/)
- [Maps](/learn/by-example/maps/)
- [Anydata type](/learn/by-example/anydata-type/)
