# Extract a ZIP archive

The Ballerina `zip` library unpacks every entry of an archive into a directory with `decompress`, creating the directory when it is missing. `zip:DecompressOptions` decides what becomes of a file already sitting where an entry unpacks to, and caps what the extraction is allowed to cost.

For more information on the underlying module, see the [`zip` module](https://lib.ballerina.io/ballerina/zip/latest/).

::: code zip_decompress.bal :::

::: out zip_decompress.out :::
