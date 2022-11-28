# SFTP service - Read/Write file

The SFTP service is used to receive file/directory changes that occur in a remote location using the SFTP protocol. This sample includes receiving file/directory related change events from a listener and using the `append` api of the `ftp:Caller` to interact with the SFTP server.

::: code sftp_service_read_write.bal :::

## Prerequisites
- Execute [SFTP client - Write file](/learn/by-example/sftp-client-write) example to put a file in the FTP server.

Run the program by executing the following command. Each newly added file in the SFTP server will be appended with the content in the appending file.

::: out sftp_service_read_write.out :::

## Related links
- [`ftp:Caller` client object - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Caller)
- [`ftp:Caller` function - Specification](/spec/ftp/#52-functions)
