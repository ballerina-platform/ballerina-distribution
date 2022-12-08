# FTP client - Read file

The FTP client can be used to read files on remote servers using the FTP protocol. An `ftp:Client` can be created with default configurations and the `get` API can be used to read the files. This returns the file content as a `byte[]` stream which can then be written to another file/output to console.

::: code ftp_client_read.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.
- Run the FTP client given in the [FTP client - Write file](/learn/by-example/ftp-client-write) example to put a file in the FTP server.

Run the program by executing the following command. The newly-added file will appear in the local directory.

::: out ftp_client_read.out :::

## Related links
- [`ftp:Client->get` method - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Client#get)
- [FTP client - Specification](/spec/ftp/#321-insecure-client)
