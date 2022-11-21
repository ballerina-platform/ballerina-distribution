# FTP service - Read/Write file

The FTP service is used to receive file/directory changes that occur in a remote location using the FTP protocol. This sample includes receiving file/directory related change events from a listener and using the `append` api of the `ftp:Caller` to interact with the FTP server.

For more information on the underlying module, see the [`ftp` module](https://lib.ballerina.io/ballerina/ftp/latest/).

::: code ftp_service_read_write.bal :::

Each newly added file in the SFTP server will be appended with the content in the appending file.

::: out ftp_service_read_write.out :::
