# SFTP client - Read file

The `ftp:Client` connects to a given SFTP server, and then reads and writes files on it. An `ftp:Client` with SFTP protocol is created by giving the protocol, host-name, required credentials, and the private key. Once connected, `getText`, `getJson`, `getXml`, `getCsv`, and `getBytes` read a file as a value of the matching type from the SFTP server. `getJson`, `getXml`, and `getCsv` bind the content to the type expected at the call site. Use this to transfer files from a remote file system to a local file system.

::: code sftp_client_read_file.bal :::

## Prerequisites
- Start an [SFTP server](https://hub.docker.com/r/atmoz/sftp/) instance.
- Run the SFTP client given in the [SFTP client - Write file](/learn/by-example/sftp-client-write-file) example to put a file in the SFTP server.

Run the program by executing the following command. The newly-added file will appear in the local directory.

::: out sftp_client_read_file.out :::

## Related links
- [`ftp:Client->getText` method - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#Client#getText)
- [SFTP client - Specification](/spec/ftp/#322-secure-client)
