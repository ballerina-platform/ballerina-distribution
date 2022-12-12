# FTP service - Read/Write file

The `ftp:Service` connects to a given FTP server via the `ftp:Listener` and then sends and receives files as byte streams via the `ftp:Caller`. The `ftp:Caller` is available as a parameter in the `onFileChange` method which is created with the configurations provided to the `ftp:Listener`. Once the `onFileChange` is invoked, the `append` method of FTP caller can be used to append a file to the files existing in the FTP server. Use this to listen to file changes occurring in a remote file system and do CRUD operations with the remote server.

::: code ftp_service_read_write.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. Each newly added file in the FTP server will be appended with the content in the appending file.

::: out ftp_service_read_write.out :::

>**Tip:** Run the FTP client given in the [FTP client - Write file](/learn/by-example/ftp-client-write) example to put a file in the FTP server.

## Related links
- [`ftp:Caller` client object  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Caller)
- [`ftp:Caller` functions - Specification](/spec/ftp/#52-functions)
