# FTP client - Send file

The `ftp:Client` connects to a given FTP server, and then reads and writes files on it. An `ftp:Client` is created by giving the host-name and required credentials. Once connected, `putText`, `putJson`, `putXml`, `putCsv`, and `putBytes` write a value of the matching type to the FTP server, so the content does not have to be serialized first. Use this to transfer files from a local file system to a remote file system.

::: code ftp_client_send_file.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. The newly-added file will appear in the FTP server.

::: out ftp_client_send_file.out :::

## Related links
- [`ftp:Client->putText` method - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#Client#putText)
- [FTP client - Specification](/spec/ftp/#321-insecure-client)
