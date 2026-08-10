# SFTP service - Receive file

The `ftp:Service` connects to a given SFTP server via the `ftp:Listener`. A `ftp:Listener` with SFTP protocol is created by providing the protocol, host-name, required credentials, and the private key. The directory each service watches is given by the `@ftp:ServiceConfig` annotation. Once connected, the listener polls that directory and dispatches every file it finds to the service. The handler is selected by the file extension and the content is bound to its first parameter, so `onFileText` receives the file as a string and the handler never reads it. `onFileJson`, `onFileXml`, and `onFileCsv` bind the other content types. Use this to act on files as they arrive on a remote file system.

::: code sftp_service_receive_file.bal :::

## Prerequisites
- Start a [SFTP server](https://hub.docker.com/r/atmoz/sftp/) instance.

Run the program by executing the following command. Each newly added file in the SFTP server will be saved in the local file system.

::: out sftp_service_receive_file.out :::

>**Tip:** Place a `.txt` file in `/home/in` on the SFTP server to trigger the service. The [SFTP client - Send file](/learn/by-example/sftp-client-send-file) example writes to `/server`, so point it at `/home/in` to use it here.

## Related links
- [`ftp:Listener` client object - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#Listener)
- [SFTP service - Specification](/spec/ftp/#422-secure-listener)
