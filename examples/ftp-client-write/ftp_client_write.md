# FTP client - Write file

The FTP client is used to perform CRUD operation on remote files/directories using the FTP protocol. This sample includes putting file content with default configurations using the default port number.

::: code ftp_client_write.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. The newly-added file will appear in the FTP server.

::: out ftp_client_write.out :::

## Related links
- [`ftp:Client->put` method - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Client#put)
- [FTP client - Specification](/spec/ftp/#321-insecure-client)
