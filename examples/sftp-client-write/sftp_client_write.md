# SFTP client - Write file

The SFTP client can be used to write files to a remote server using the SFTP protocol. An `ftp:Client` can be created by providing configurations related to SFTP protocol and the `put` API can be used to put a file on the server.

::: code sftp_client_write.bal :::

## Prerequisites
- Start a [SFTP server](https://hub.docker.com/r/atmoz/sftp/) instance.

Run the program by executing the following command. The newly-added file will appear in the SFTP server.

::: out sftp_client_write.out :::

## Related links
- [`ftp:Client->put` method  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Client#put)
- [SFTP client - Specification](/spec/ftp/#322-secure-client)
