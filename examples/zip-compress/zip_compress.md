# Create a ZIP archive

The Ballerina `zip` library archives a file or a directory into a ZIP file with `compress`. The compression level, whether the source directory becomes the root entry of the archive, and whether a file already at the target path is replaced are all given through `zip:CompressOptions`.

For more information on the underlying module, see the [`zip` module](https://lib.ballerina.io/ballerina/zip/latest/).

::: code zip_compress.bal :::

## Prerequisites
- Place the files to archive in a `resources/reports` directory. This example ships one holding `region-totals.csv` and `notes.txt`.

Run the program by executing the following command. The `reports.zip` archive appears in the current directory.

::: out zip_compress.out :::
