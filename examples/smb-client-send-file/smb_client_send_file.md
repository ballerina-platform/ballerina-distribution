# SMB client - Send file

The `smb:Client` connects to a directory share on a given SMB server, and then reads and writes files on it. An `smb:Client` is created by giving the host-name, the share, and the required credentials. Once connected, the `putBytes` method is used to write a file to the share. Every path given to the client is relative to that share. Use this to transfer files from a local file system to a Windows file server, a NAS appliance, or a Samba share.

::: code smb_client_send_file.bal :::

## Prerequisites
- Start a [Samba server](https://hub.docker.com/r/dperson/samba) instance with a share named `reports`.

Run the program by executing the following command. The newly-added file will appear in the share.

::: out smb_client_send_file.out :::

## Related links
- [`smb:Client->putBytes` method - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Client#putBytes)
- [`smb:Client` client object - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Client)
