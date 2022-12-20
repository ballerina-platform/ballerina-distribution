# Default values for record fields

Ballerina allows default values for record fields as part of the record's type descriptor. A default value is an expression. Default values do not affect static typing. They only affect the use of type descriptors to construct records. Calling the `value:cloneWithType()` function with a record type descriptor `T` will make use of default values in `T` if required. Similarly, using `*T` in type inclusions also copies the default values.

::: code default_values_for_record_fields.bal :::

::: out default_values_for_record_fields.out :::

## Related links
- [Records](/learn/by-example/records/)
- [Type inclusion for records](/learn/by-example/type-inclusion-for-records/)
- [Maps](/learn/by-example/maps/)
