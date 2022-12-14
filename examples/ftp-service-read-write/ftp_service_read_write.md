# FTP service - Read/Write file

The `ftp:Service` connects to a given FTP server via the `ftp:Listener`. Once connected, the service starts receiving events every time a file is deleted or added to the server. To take action for these events `ftp:Caller` is used. The `ftp:Caller` can be specified as a parameter of `onFileChange` remote method. The `ftp:Caller` allows interacting with the server via `get`, `append`, `delete`, etc remote methods. Use this to listen to file changes occurring in a remote file system and take action for those changes.

::: code ftp_service_read_write.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. Each newly added file in the FTP server will be appended with the content in the appending file.

::: out ftp_service_read_write.out :::

>**Tip:** Run the FTP client given in the [FTP client - Write file](/learn/by-example/ftp-client-write) example to put a file in the FTP server.

## Related links
- [`ftp:Caller` client object  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/clients/Caller)
- [`ftp:Caller` functions - Specification](/spec/ftp/#52-functions)
