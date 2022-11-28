# FTP service - Read file

The FTP listener is used to receive file/directory changes that occur in a remote location using the FTP protocol. This sample includes receiving file/directory related change events from a listener with default configurations using the default port.

::: code ftp_service_read.bal :::

## Prerequisites
- Execute [FTP client - Write file](/learn/by-example/ftp-client-write) example to put a file in the FTP server.

Run the program by executing the following command. Paths of the newly-added and newly-deleted files/directories during the latest polling will be printed for each of the polled events.

::: out ftp_service_read.out :::

## Related links
- [`ftp:Listener` client object  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/listeners/Listener)
- [FTP listener - Specification](/spec/ftp/#422-secure-listener)
