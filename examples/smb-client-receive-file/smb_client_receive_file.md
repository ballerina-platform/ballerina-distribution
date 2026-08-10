# SMB client - Receive file

The `smb:Client` connects to a directory share on a given SMB server, and then reads and writes files on it. An `smb:Client` is created by giving the host-name, the share, and the required credentials. Once connected, the `getBytes` method is used to read a file from the share. The client also reads a file directly as a value with `getText`, `getJson`, `getXml`, and `getCsv`. Use this to transfer files from a Windows file server, a NAS appliance, or a Samba share to a local file system.

::: code smb_client_receive_file.bal :::

## Prerequisites
- Start a [Samba server](https://hub.docker.com/r/dperson/samba) instance with a share named `reports`, holding a file at `/server/logFile.txt`.

Run the program by executing the following command. The file read from the share will be saved in the local file system.

::: out smb_client_receive_file.out :::

>**Tip:** Run the SMB client given in the [SMB client - Send file](/learn/by-example/smb-client-send-file) example to put a file in the share.

## Related links
- [`smb:Client->getBytes` method - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Client#getBytes)
- [`smb:Client` client object - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Client)
