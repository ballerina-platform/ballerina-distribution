# SFTP client - Read file

The SFTP client is used to perform CRUD operation on remote files/directories using the SFTP protocol. This sample includes getting a file content with default configurations using the default port number.

::: code sftp_client_read.bal :::

## Prerequisites
- Run the SFTP client given in the [SFTP client - Write file](/learn/by-example/sftp-client-write) example to put a file in the FTP server.

Run the program by executing the following command. The newly-added file will appear in the local directory.

::: out sftp_client_read.out :::

## Related links
- [`ftp:Client->get` method  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Client#get)
- [SFTP client - Specification](/spec/ftp/#322-secure-client)
