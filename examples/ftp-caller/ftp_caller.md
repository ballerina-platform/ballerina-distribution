# FTP service - Caller object

The `ftp:Service` connects to a given FTP server via the `ftp:Listener`. The directory each service watches is given by the `@ftp:ServiceConfig` annotation. Once connected, the listener polls that directory and dispatches every file it finds to the service. To write back to the server while handling a file, an `ftp:Caller` is declared as a parameter of the handler. The `ftp:Caller` is the connection the listener already holds, and it writes with `putText`, `putJson`, `putXml`, `putCsv`, and `putBytes`, and also deletes and renames files. Use this to produce a result on the remote file system for each file that arrives.

::: code ftp_caller.bal :::

## Prerequisites
- Start an [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. A receipt line is appended to each new shipment note in the watched directory.

::: out ftp_caller.out :::

>**Tip:** Place a `.txt` file in `/home/in` on the FTP server to trigger the service.

## Related links
- [`ftp:Caller` client object - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#Caller)
- [`ftp:Caller` functions - Specification](/spec/ftp/#52-functions)
