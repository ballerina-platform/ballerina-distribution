# FTP client - Write file

The FTP client can be used to write files to a remote server using the FTP protocol. An `ftp:Client` can be created with default configurations and the `put` API can be used to put a file on the server.

::: code ftp_client_write.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. The newly-added file will appear in the FTP server.

::: out ftp_client_write.out :::

## Related links
- [`ftp:Client->put` method - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Client#put)
- [FTP client - Specification](/spec/ftp/#321-insecure-client)
