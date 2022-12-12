# FTP service - Read file

The FTP service connects to a given FTP server via the FTP listener and receives file changes (additions, deletions) occurring in the FTP server. An FTP listener is created by giving the host-name and required credentials and gets attached to the FTP service. Once connected, the `onFileChange` method is invoked with the remote file changes as a `ftp:WatchEvent`. Use this to listen to file changes occurring in a remote file system.

::: code ftp_service_read.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. Paths of the newly-added and newly-deleted files/directories during the latest polling will be printed for each of the polled events.

::: out ftp_service_read.out :::

>**Tip:** Run the FTP client given in the [FTP client - Write file](/learn/by-example/ftp-client-write) example to put a file in the FTP server.

## Related links
- [`ftp:Listener` client object  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/listeners/Listener)
- [FTP service - Specification](/spec/ftp/#422-secure-listener)
