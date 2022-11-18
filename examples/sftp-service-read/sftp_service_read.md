# Listener

The SFTP service is used to receive file/directory changes that occur in a remote location using the SFTP protocol. This sample includes receiving file/directory related change events from a listener with default configurations using the default port.

For more information on the underlying module,  see the [`ftp` module](https://lib.ballerina.io/ballerina/ftp/latest/).

::: code sftp_listener.bal :::

Paths of the newly-added and newly-deleted files/directories during the latest polling will be printed for each of the polled events.

::: out sftp_listener.out :::
