# FTP service - Read file

The `ftp:Service` connects to a given FTP server via the `ftp:Listener`. An `ftp:Listener` is created by providing the host-name and required credentials. Once connected, the `onFileChange` remote method of the service starts receiving events as a `ftp:WatchEvent` every time a file is deleted or added to the server. Use this to listen to file changes occurring in a remote file system.

::: code ftp_service_read.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. Paths of the newly-added and newly-deleted files/directories during the latest polling will be printed for each of the polled events.

::: out ftp_service_read.out :::

>**Tip:** Run the FTP client given in the [FTP client - Write file](/learn/by-example/ftp-client-write) example to put a file in the FTP server.

## Related links
- [`ftp:Listener` client object  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/listeners/Listener)
- [FTP service - Specification](/spec/ftp/#422-secure-listener)
