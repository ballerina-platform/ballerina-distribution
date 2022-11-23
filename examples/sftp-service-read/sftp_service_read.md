# SFTP service - Read file

The SFTP service is used to receive file/directory changes that occur in a remote location using the SFTP protocol. This sample includes receiving file/directory related change events from a listener with default configurations using the default port.

::: code sftp_service_read.bal :::

Paths of the newly-added and newly-deleted files/directories during the latest polling will be printed for each of the polled events.

::: out sftp_service_read.out :::

## Related links
- [`ftp:Listener` - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/listeners/Listener)
- [SFTP listener - specification](/spec/ftp/#422-secure-listener)
