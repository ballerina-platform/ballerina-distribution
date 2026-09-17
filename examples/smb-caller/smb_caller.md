# SMB service - Caller object

An SMB service reacts to the files that arrive in the directory it watches. To act on the share while handling one of those files, the service declares an `smb:Caller` parameter on the handler. The `smb:Caller` is the share connection the listener already holds, so no second connection is opened. It offers the same operations as the `smb:Client`: `putText`, `putJson`, `putXml`, `putCsv`, and `putBytes` to write, the matching `get` methods to read, and `move`, `copy`, `rename`, and `delete` to manage files. Use this to produce a result on the remote file system for each file that arrives.

::: code smb_caller.bal :::

## Prerequisites
- Start a [Samba server](https://hub.docker.com/r/dperson/samba) instance with a share named `reports`, containing the `/sales/new` and `/sales/ack` directories. The image creates no users, so add `user1` with the password `pass456` in the `WORKGROUP` domain.

Run the program by executing the following command. An acknowledgement file is written to `/sales/ack` for each new file in the watched directory.

::: out smb_caller.out :::

>**Tip:** Place a `.json` file holding `storeId`, `saleDate`, and `total` in `/sales/new` on the share to trigger the service.

## Related links
- [`smb:Caller` client object - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Caller)
- [`smb:Listener` listener object - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Listener)
