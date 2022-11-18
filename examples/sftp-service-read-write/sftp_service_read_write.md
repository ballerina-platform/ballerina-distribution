# Service Read/Write

The SFTP service is used to receive file/directory changes that occur in a remote location using the SFTP protocol. This sample includes receiving file/directory related change events from a listener and using the `append` api of the `ftp:Caller` to interact with the SFTP server.

For more information on the underlying module,  see the [`ftp` module](https://lib.ballerina.io/ballerina/ftp/latest/).

::: code sftp_service_read_write.bal :::

Each newly added file in the SFTP server will be appended with the content in the appending file.

::: out sftp_service_read_write.out :::
