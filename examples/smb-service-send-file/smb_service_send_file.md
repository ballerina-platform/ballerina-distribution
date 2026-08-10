# SMB service - Send file

An SMB service connects to a directory share on a given SMB server via the `smb:Listener`. Once connected, the listener polls the directory given in `@smb:ServiceConfig` and dispatches every file it finds to the service. To write back to the share while handling a file, an `smb:Caller` is declared as a parameter of the handler. The `smb:Caller` is the share connection the listener already holds, and it writes with `putText`, `putBytes`, `putJson`, `putXml`, and `putCsv`, as well as moving, copying, and deleting files. Use this to produce a response on the remote file system for each file that arrives.

::: code smb_service_send_file.bal :::

## Prerequisites
- Start a [Samba server](https://hub.docker.com/r/dperson/samba) instance with a share named `reports`, containing the `/home/in` and `/home/out` directories.

Run the program by executing the following command. An acknowledgement file will be written to `/home/out` for each new file in the watched directory.

::: out smb_service_send_file.out :::

>**Tip:** Run the SMB client given in the [SMB client - Send file](/learn/by-example/smb-client-send-file) example to put a file in the share.

## Related links
- [`smb:Caller` client object - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Caller)
- [`smb:Listener` listener object - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Listener)
