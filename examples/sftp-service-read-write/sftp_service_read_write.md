# SFTP service - Read/Write file

The FTP service connects to a given SFTP server via the SFTP listener and then sends and receives files as byte streams via the FTP caller. The FTP caller is available as a parameter in the `onFileChange` method which is created with the configurations provided to the SFTP listener. Once the `onFileChange` is invoked, the `append` method of FTP caller can be used to append a file to the files existing in the SFTP server. Use this to listen to file changes occurring in a remote file system and do CRUD operations with the remote server.

::: code sftp_service_read_write.bal :::

## Prerequisites
- Start a [SFTP server](https://hub.docker.com/r/atmoz/sftp/) instance.

Run the program by executing the following command. Each newly added file in the SFTP server will be appended with the content in the appending file.

::: out sftp_service_read_write.out :::

>**Tip:** Run the SFTP client given in the [SFTP client - Write file](/learn/by-example/sftp-client-write) example to put a file in the SFTP server.

## Related links
- [`ftp:Caller` client object - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Caller)
- [`ftp:Caller` functions - Specification](/spec/ftp/#52-functions)
