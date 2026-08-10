# FTP service - Send file

The `ftp:Service` connects to a given FTP server via the `ftp:Listener`. The directory each service watches is given by the `@ftp:ServiceConfig` annotation. Once connected, the listener polls that directory and dispatches every file it finds to the service. To write back to the server while handling a file, an `ftp:Caller` is declared as a parameter of the handler. The `ftp:Caller` is the connection the listener already holds, and it writes with `putText`, `putJson`, `putXml`, `putCsv`, and `putBytes`, and also deletes and renames files. Use this to produce a result on the remote file system for each file that arrives.

::: code ftp_service_send_file.bal :::

## Prerequisites
- Start a [FTP server](https://hub.docker.com/r/stilliard/pure-ftpd/) instance.

Run the program by executing the following command. Each newly added file in the FTP server will be appended with the content in the appending file.

::: out ftp_service_send_file.out :::

>**Tip:** Place a `.txt` file in `/home/in` on the FTP server to trigger the service. The [FTP client - Send file](/learn/by-example/ftp-client-send-file) example writes to `/server`, so point it at `/home/in` to use it here.

## Related links
- [`ftp:Caller` client object  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#Caller)
- [`ftp:Caller` functions - Specification](/spec/ftp/#52-functions)
