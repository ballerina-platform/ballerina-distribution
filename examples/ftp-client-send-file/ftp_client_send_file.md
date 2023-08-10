# FTP client - Send file

The `ftp:Client` connects to a given FTP server, and then sends and receives files as byte streams. An `ftp:Client` is created by giving the host-name and required credentials. Once connected, `put` method is used to write files as byte streams to the FTP server. Use this to transfer files from a local file system to a remote file system.

::: code ftp_client_send_file.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. The newly-added file will appear in the FTP server.

::: out ftp_client_send_file.out :::

## Related links
- [`ftp:Client->put` method - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#Client#put)
- [FTP client - Specification](/spec/ftp/#321-insecure-client)
