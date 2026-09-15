# SMB service - Receive file

An SMB service connects to a directory share on a given SMB server via the `smb:Listener`. An `smb:Listener` is created by providing the host-name, the share, and the required credentials. Once connected, the listener polls the directory given in `@smb:ServiceConfig` and dispatches every file it finds to the service. The handler is selected by the file extension and the content is bound to its first parameter, so `onFileJson` receives a value mapped from the JSON content and the handler never reads the file itself. The `afterProcess` action of `@smb:FunctionConfig` then moves the file, keeping file management out of the handler. Use this to act on files as they arrive on a remote file system.

::: code smb_service_receive_file.bal :::

## Prerequisites
- Start a [Samba server](https://hub.docker.com/r/dperson/samba) instance with a share named `reports`, containing the `/sales/new` and `/sales/processed` directories. The image creates no users, so add `user1` with the password `pass456` in the `WORKGROUP` domain.

Run the program by executing the following command. Each new file in the watched directory is dispatched to the handler and then moved to `/sales/processed`.

::: out smb_service_receive_file.out :::

>**Tip:** Place a `.json` file holding `storeId`, `saleDate`, and `total` in `/sales/new` on the share to trigger the service.

## Related links
- [`smb:Listener` listener object - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Listener)
- [`smb:FunctionConfig` annotation - API documentation](https://lib.ballerina.io/ballerina/smb/latest#FunctionConfig)
