# SFTP service - Caller object

The `ftp:Service` connects to a given SFTP server via the `ftp:Listener`. The directory each service watches is given by the `@ftp:ServiceConfig` annotation. Once connected, the listener polls that directory and dispatches every file it finds to the service. To write back to the server while handling a file, an `ftp:Caller` is declared as a parameter of the handler. The `ftp:Caller` is the connection the listener already holds, and it writes with `putText`, `putJson`, `putXml`, `putCsv`, and `putBytes`, and also deletes and renames files. The listener dispatches every file it finds on each poll, so `@ftp:FunctionConfig` moves the handled file out of the watched directory. Use this to produce a result on the remote file system for each file that arrives.

::: code sftp_caller.bal :::

## Prerequisites
- Start an [SFTP server](https://hub.docker.com/r/atmoz/sftp/) instance containing the `/home/in`, `/home/processed`, and `/home/failed` directories.

Run the program by executing the following command. A receipt line is appended to each new shipment note in the watched directory, and the note is then moved to `/home/processed`.

::: out sftp_caller.out :::

>**Tip:** Place a `.txt` file in `/home/in` on the SFTP server to trigger the service.

## Related links
- [`ftp:Caller` client object - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#Caller)
- [`ftp:Caller` functions - Specification](/spec/ftp/#52-functions)
