# FTP service - Read file

The FTP listener can be used to receive file/directory changes that occur in a remote location using the FTP protocol. An `ftp:Listener` can be created with default configurations and can be attached to a `ftp:Service` which contains the remote method `onFileChange` which gets invoked when there are file/directory changes in the remote server. This can be used when the file changes are required implicitly.

::: code ftp_service_read.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. Paths of the newly-added and newly-deleted files/directories during the latest polling will be printed for each of the polled events.

::: out ftp_service_read.out :::

>**Tip:** Run the FTP client given in the [FTP client - Write file](/learn/by-example/ftp-client-write) example to put a file in the FTP server.

## Related links
- [`ftp:Listener` client object  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/listeners/Listener)
- [FTP service - Specification](/spec/ftp/#422-secure-listener)
