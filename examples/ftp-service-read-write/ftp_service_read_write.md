# Service Read/Write

The FTP service is used to receive file/directory changes that occur in a remote location using the FTP protocol. This sample includes receiving file/directory related change events from a listener and using the `append` api of the `ftp:Caller` to interact with the FTP server.

For more information on the underlying module, see the [`ftp` module](https://lib.ballerina.io/ballerina/ftp/latest/).

::: code ftp_listener.bal :::

Paths of the newly-added and newly-deleted files/directories during the latest polling will be printed for each of the polled events.

::: out ftp_listener.out :::
