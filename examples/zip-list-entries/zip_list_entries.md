# List archive entries

The Ballerina `zip` library reads what an archive holds without unpacking it. `listEntries` returns a `zip:Entry` for every file and directory in the archive, carrying its name, its size before and after compression, the compression method, the modified time, and the CRC-32 checksum of the content.

For more information on the underlying module, see the [`zip` module](https://lib.ballerina.io/ballerina/zip/latest/).

::: code zip_list_entries.bal :::

::: out zip_list_entries.out :::
