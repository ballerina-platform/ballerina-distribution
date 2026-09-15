# SMB client - Write file

The `smb:Client` connects to a directory share on a given SMB server, and then reads and writes files on it. An `smb:Client` is created by giving the host-name, the share, and the required credentials. Once connected, `putText`, `putJson`, `putXml`, `putCsv`, and `putBytes` write a value of the matching type to the share, so the content does not have to be serialized first. Every path given to the client is relative to the share. Use this to write files to a Windows file server, a NAS appliance, or a Samba share.

::: code smb_client_write_file.bal :::

## Prerequisites
- Start a [Samba server](https://hub.docker.com/r/dperson/samba) instance with a share named `reports`, holding a `/reports` directory. The image creates no users, so add `user1` with the password `pass456` in the `WORKGROUP` domain.

Run the program by executing the following command. The two newly-added files will appear in the share.

::: out smb_client_write_file.out :::

## Related links
- [`smb:Client->putText` method - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Client#putText)
- [`smb:Client->putJson` method - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Client#putJson)
- [`smb:Client` client object - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Client)
