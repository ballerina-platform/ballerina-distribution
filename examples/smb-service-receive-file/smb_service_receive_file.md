# SMB service - Receive file

An SMB service connects to a directory share on a given SMB server via the `smb:Listener`. An `smb:Listener` is created by providing the host-name, the share, and the required credentials. Once connected, the listener polls the directory given in `@smb:ServiceConfig` and dispatches every file it finds to the service. The handler is chosen by file extension, and the file content is bound to its first parameter, so `onFileText` receives a `string`, `onFileJson` receives a value mapped from JSON, and `onFile` receives a `byte[]`. Use this to act on files as they arrive on a remote file system.

::: code smb_service_receive_file.bal :::

## Prerequisites
- Start a [Samba server](https://hub.docker.com/r/dperson/samba) instance with a share named `reports`, containing the `/home/in` and `/home/processed` directories.

Run the program by executing the following command. Each new file in the watched directory will be saved in the local file system and then moved to `/home/processed`.

::: out smb_service_receive_file.out :::

>**Tip:** Run the SMB client given in the [SMB client - Send file](/learn/by-example/smb-client-send-file) example to put a file in the share.

## Related links
- [`smb:Listener` listener object - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Listener)
- [`smb:FunctionConfig` annotation - API documentation](https://lib.ballerina.io/ballerina/smb/latest#FunctionConfig)
