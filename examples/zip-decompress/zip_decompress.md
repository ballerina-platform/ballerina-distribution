# Extract a ZIP archive

The Ballerina `zip` library reads what an archive holds without unpacking it: `listEntries` returns a `zip:Entry` for every file and directory, carrying its name, its size before and after compression, the compression method, the modified time, and the CRC-32 checksum of the content. `decompress` then unpacks every entry into a directory, creating the directory when it is missing. `zip:DecompressOptions` decides what becomes of a file already sitting where an entry unpacks to, and caps what the extraction is allowed to cost.

For more information on the underlying module, see the [`zip` module](https://lib.ballerina.io/ballerina/zip/latest/).

::: code zip_decompress.bal :::

## Prerequisites
- Run the [Create a ZIP archive](/learn/by-example/zip-compress) example to put `reports.zip` in the current directory.

Run the program by executing the following command. The entries are printed, and the unpacked files appear under the `restored` directory.

::: out zip_decompress.out :::
