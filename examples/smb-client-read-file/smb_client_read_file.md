# SMB client - Read file

The `smb:Client` connects to a directory share on a given SMB server, and then reads and writes files on it. Once connected, `getText`, `getJson`, `getXml`, `getCsv`, and `getBytes` read a file as a value of the matching type. `getJson`, `getXml`, and `getCsv` bind the content to the type expected at the call site, so a file can be read straight into a record. Use this to read files from a Windows file server, a NAS appliance, or a Samba share.

::: code smb_client_read_file.bal :::

## Prerequisites
- Start a [Samba server](https://hub.docker.com/r/dperson/samba) instance with a share named `reports`, holding a `/reports` directory. The image creates no users, so add `user1` with the password `pass456` in the `WORKGROUP` domain.
- Place `summary.txt` and `summary.json` in `/reports` on the share.

Run the program by executing the following command.

::: out smb_client_read_file.out :::

>**Tip:** Run the SMB client given in the [SMB client - Write file](/learn/by-example/smb-client-write-file) example to create both files at the paths this example reads.

## Related links
- [`smb:Client->getText` method - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Client#getText)
- [`smb:Client->getJson` method - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Client#getJson)
- [`smb:Client` client object - API documentation](https://lib.ballerina.io/ballerina/smb/latest#Client)
