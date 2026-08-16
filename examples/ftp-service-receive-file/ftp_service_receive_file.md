# FTP service - Receive file

The `ftp:Service` connects to a given FTP server via the `ftp:Listener`. An `ftp:Listener` is created by providing the host-name and required credentials. The directory each service watches is given by the `@ftp:ServiceConfig` annotation. Once connected, the listener polls that directory and dispatches every file it finds to the service. The handler is selected by the file extension and the content is bound to its first parameter, so `onFileText` receives the file as a string and the handler never reads it. `onFileJson`, `onFileXml`, and `onFileCsv` bind the other content types. The `afterProcess` and `afterError` actions of `@ftp:FunctionConfig` then move the file, keeping file management out of the handler, and `onError` is called when a file cannot be read, cannot be bound to the handler parameter, or the handler itself fails. Use this to act on files as they arrive on a remote file system.

::: code ftp_service_receive_file.bal :::

## Prerequisites
- Start an [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance containing the `/home/in`, `/home/processed`, and `/home/failed` directories.

Run the program by executing the following command. Each new shipment note in the watched directory is archived on the local file system and then moved to `/home/processed`.

::: out ftp_service_receive_file.out :::

>**Tip:** Place a `.txt` file in `/home/in` on the FTP server to trigger the service.

## Related links
- [`ftp:Listener` listener object - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#Listener)
- [`ftp:FunctionConfig` annotation - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#FunctionConfig)
- [FTP service - Specification](/spec/ftp/#431-insecure-listener)
