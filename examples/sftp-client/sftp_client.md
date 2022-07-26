# Client

The SFTP client is used to perform CRUD operation on remote
files/directories using the SFTP protocol. This sample includes getting and
putting file content with default configurations using the default port number.

For more information on the underlying module, 
see the [FTP module](https://lib.ballerina.io/ballerina/ftp/latest).

::: code sftp_client.bal :::

File content of the received file would get printed. The newly-added file will appear in the SFTP server.

::: out sftp_client.out :::
