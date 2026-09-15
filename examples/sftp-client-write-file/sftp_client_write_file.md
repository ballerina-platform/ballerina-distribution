# SFTP client - Write file

The `ftp:Client` connects to a given SFTP server, and then reads and writes files on it. An `ftp:Client` with SFTP protocol is created by giving the protocol, host-name, required credentials, and the private key. Once connected, `putText`, `putJson`, `putXml`, `putCsv`, and `putBytes` write a value of the matching type to the SFTP server, so the content does not have to be serialized first. Use this to transfer files from a local file system to a remote file system.

::: code sftp_client_write_file.bal :::

## Prerequisites
- Start an [SFTP server](https://hub.docker.com/r/atmoz/sftp/) instance.

Run the program by executing the following command. The newly-added file will appear in the SFTP server.

::: out sftp_client_write_file.out :::

## Related links
- [`ftp:Client->putText` method - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#Client#putText)
- [SFTP client - Specification](/spec/ftp/#322-secure-client)
