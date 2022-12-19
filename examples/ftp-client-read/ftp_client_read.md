# FTP client - Receive file

The `ftp:Client` connects to a given FTP server, and then sends and receives files as byte streams. An `ftp:Client` is created by giving the host-name and required credentials. Once connected, `get` method is used to read files as byte streams from the FTP server. Use this to transfer files from a remote file system to a local file system.

::: code ftp_client_read.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.
- Run the FTP client given in the [FTP client - Write file](/learn/by-example/ftp-client-write) example to put a file in the FTP server.

Run the program by executing the following command. The newly-added file will appear in the local directory.

::: out ftp_client_read.out :::

## Related links
- [`ftp:Client->get` method - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Client#get)
- [FTP client - Specification](/spec/ftp/#321-insecure-client)
