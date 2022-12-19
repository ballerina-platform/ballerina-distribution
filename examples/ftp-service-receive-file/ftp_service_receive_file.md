# FTP service - Receive file

The `ftp:Service` connects to a given FTP server via the `ftp:Listener`. A `ftp:Listener` is created by providing the host-name and required credentials. Once connected, the service starts receiving events every time a file is deleted or added to the server. To take action for these events `ftp:Caller` is used. The `ftp:Caller` can be specified as a parameter of `onFileChange` remote method. The `ftp:Caller` allows interacting with the server via `get`, `append`, `delete`, etc remote methods. Use this to listen to file changes occurring in a remote file system and take action for those changes.

::: code ftp_service_receive_file.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. Paths of the newly-added and newly-deleted files/directories during the latest polling will be printed for each of the polled events.

::: out ftp_service_receive_file.out :::

>**Tip:** Run the FTP client given in the [FTP client - Send file](/learn/by-example/ftp-client-send-file) example to put a file in the FTP server.

## Related links
- [`ftp:Listener` client object  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest/listeners/Listener)
- [FTP service - Specification](/spec/ftp/#422-secure-listener)
