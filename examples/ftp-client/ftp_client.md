# Client

The FTP client is used to perform CRUD operation on remote files/directories using the FTP protocol.

This sample includes getting and putting file content with default configurations using the default port number.

For more information on the underlying module, see the [FTP module](https://lib.ballerina.io/ballerina/ftp/latest).

::: code ftp_client.bal :::

File content of the received file would get printed. The newly-added file will appear in the FTP server.

::: out ftp_client.out :::
