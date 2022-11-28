# FTP client - Read file

The FTP client is used to perform CRUD operation on remote files/directories using the FTP protocol. This sample includes getting file content with default configurations using the default port number.

::: code ftp_client_read.bal :::

## Prerequisites
- Run the FTP client given in the [FTP client - Write file](/learn/by-example/ftp-client-write) example to put a file in the FTP server.

Run the program by executing the following command. The newly-added file will appear in the local directory.

::: out ftp_client_read.out :::

## Related links
- [`ftp:Client->get` method - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Client#get)
- [FTP client - Specification](/spec/ftp/#321-insecure-client)
