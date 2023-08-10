# SFTP service - Send file

The `ftp:Service` connects to a given SFTP server via the `ftp:Listener`. Once connected, service starts receiving events every time a file is deleted or added to the server. To take action for these events `ftp:Caller` is used. The `ftp:Caller` can be specified as a parameter of `onFileChange` remote method. The `ftp:Caller` allows interacting with the server via `get`, `append`, `delete`, etc remote methods. Use this to listen to file changes occurring in a remote file system and take action for those changes.

::: code sftp_service_send_file.bal :::

## Prerequisites
- Start a [SFTP server](https://hub.docker.com/r/atmoz/sftp/) instance.

Run the program by executing the following command. Each newly added file in the SFTP server will be appended with the content in the appending file.

::: out sftp_service_send_file.out :::

>**Tip:** Run the SFTP client given in the [SFTP client - Send file](/learn/by-example/sftp-client-send-file) example to put a file in the SFTP server.

## Related links
- [`ftp:Caller` client object - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#Caller)
- [`ftp:Caller` functions - Specification](/spec/ftp/#52-functions)
