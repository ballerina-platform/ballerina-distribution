# SFTP service - Read file

The FTP service connects to a given SFTP server via the SFTP listener and receives file changes (additions, deletions) occurring in the SFTP server. An SFTP listener is created by giving the protocol, host-name and required credentials and the private key and gets attached to the FTP service. Once connected, the `onFileChange` method is invoked with the remote file changes as a `ftp:WatchEvent`. Use this to listen to file changes occurring in a remote file system.

::: code sftp_service_read.bal :::

## Prerequisites
- Start a [SFTP server](https://hub.docker.com/r/atmoz/sftp/) instance.

Run the program by executing the following command. Paths of the newly-added and newly-deleted files/directories during the latest polling will be printed for each of the polled events.

::: out sftp_service_read.out :::

>**Tip:** Run the SFTP client given in the [SFTP client - Write file](/learn/by-example/sftp-client-write) example to put a file in the SFTP server.

## Related links
- [`ftp:Listener` client object - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/listeners/Listener)
- [SFTP service - Specification](/spec/ftp/#422-secure-listener)
