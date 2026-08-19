# Create a ZIP archive

The Ballerina `zip` library archives a file or a directory into a ZIP file with `compress`. The compression level, whether the source directory becomes the root entry of the archive, and whether a file already at the target path is replaced are all given through `zip:CompressOptions`.

For more information on the underlying module, see the [`zip` module](https://lib.ballerina.io/ballerina/zip/latest/).

::: code zip_compress.bal :::

::: out zip_compress.out :::
