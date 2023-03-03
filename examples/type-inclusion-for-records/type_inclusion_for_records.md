# Type inclusion for records

Type inclusion enables you to create a record by combining fields of other records. You can include the record type `T` in the record type descriptor of another record by using the `*T` notation. This is effectively the same as copying the fields of the included records into the including record.

::: code type_inclusion_for_records.bal :::

::: out type_inclusion_for_records.out :::

## Related links
- [Records](/learn/by-example#)
- [Open Records](/learn/by-example/open-records/)
- [Default values for record fields](/learn/by-example/default-values-for-record-fields/)
