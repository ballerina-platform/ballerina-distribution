# FTP client - Read file

The `ftp:Client` connects to a given FTP server, and then reads and writes files on it. An `ftp:Client` is created by giving the host-name and required credentials. Once connected, `getText`, `getJson`, `getXml`, `getCsv`, and `getBytes` read a file as a value of the matching type from the FTP server. `getJson`, `getXml`, and `getCsv` bind the content to the type expected at the call site. Use this to transfer files from a remote file system to a local file system.

::: code ftp_client_read_file.bal :::

## Prerequisites
- Start an [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.
- Run the FTP client given in the [FTP client - Write file](/learn/by-example/ftp-client-write-file) example to put a file in the FTP server.

Run the program by executing the following command. The content is printed, and the newly-added file will appear in the local directory.

::: out ftp_client_read_file.out :::

## Related links
- [`ftp:Client->getText` method - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#Client#getText)
- [FTP client - Specification](/spec/ftp/#321-insecure-client)
