# SFTP service - Read/Write file

The SFTP service is used to receive file/directory changes that occur in a remote location using the SFTP protocol. This sample includes receiving file/directory related change events from a listener and using the `append` api of the `ftp:Caller` to interact with the SFTP server.
The `append` API of the `ftp:Caller` is used to append a file to the changed files in the SFTP server. The `ftp:Caller` can be added as an argument to the `onFileChange` remote method, where it can be used to append a file to the newly added files. This can be used when CRUD operations are needed to be done depending on the changes in the remote server.

::: code sftp_service_read_write.bal :::

## Prerequisites
- Start a [SFTP server](https://hub.docker.com/r/atmoz/sftp/) instance.

Run the program by executing the following command. Each newly added file in the SFTP server will be appended with the content in the appending file.

::: out sftp_service_read_write.out :::

>**Tip:** Run the SFTP client given in the [SFTP client - Write file](/learn/by-example/sftp-client-write) example to put a file in the SFTP server.

## Related links
- [`ftp:Caller` client object - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Caller)
- [`ftp:Caller` functions - Specification](/spec/ftp/#52-functions)
