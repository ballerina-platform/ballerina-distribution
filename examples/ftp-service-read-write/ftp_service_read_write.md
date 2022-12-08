# FTP service - Read/Write file

The `append` API of the `ftp:Caller` is used to append a file to the changed files in the FTP server. The `ftp:Caller` can be added as an argument to the `onFileChange` remote method, where it can be used to append a file to the newly added files. This can be used when CRUD operations are needed to be done depending on the changes in the remote server.

::: code ftp_service_read_write.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. Each newly added file in the SFTP server will be appended with the content in the appending file.

::: out ftp_service_read_write.out :::

>**Tip:** Run the FTP client given in the [FTP client - Write file](/learn/by-example/ftp-client-write) example to put a file in the FTP server.

## Related links
- [`ftp:Caller` client object  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Caller)
- [`ftp:Caller` functions - Specification](/spec/ftp/#52-functions)
