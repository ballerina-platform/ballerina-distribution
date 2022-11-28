# FTP service - Read/Write file

The FTP service is used to receive file/directory changes that occur in a remote location using the FTP protocol. This sample includes receiving file/directory related change events from a listener and using the `append` api of the `ftp:Caller` to interact with the FTP server.

::: code ftp_service_read_write.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. Each newly added file in the SFTP server will be appended with the content in the appending file.

::: out ftp_service_read_write.out :::

> **TIP** Run the FTP client given in the [FTP client - Write file](/learn/by-example/ftp-client-write) example to put a file in the FTP server.

## Related links
- [`ftp:Caller` client object  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Caller)
- [`ftp:Caller` functions - Specification](/spec/ftp/#52-functions)
