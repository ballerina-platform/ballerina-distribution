# SFTP client - Read file

The SFTP client can be used to read files on remote servers using the SFTP protocol. An `ftp:Client` can be created by providing configurations related to SFTP protocol and the `get` API can be used to read the files. This returns the file content as a `byte[]` stream which can then be written to another file/output to console etc.

::: code sftp_client_read.bal :::

## Prerequisites
- Start a [SFTP server](https://hub.docker.com/r/atmoz/sftp/) instance.
- Run the SFTP client given in the [SFTP client - Write file](/learn/by-example/sftp-client-write) example to put a file in the SFTP server.

Run the program by executing the following command. The newly-added file will appear in the local directory.

::: out sftp_client_read.out :::

## Related links
- [`ftp:Client->get` method  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Client#get)
- [SFTP client - Specification](/spec/ftp/#322-secure-client)
