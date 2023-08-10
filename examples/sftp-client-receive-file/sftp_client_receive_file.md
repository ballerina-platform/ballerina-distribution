# SFTP client - Receive file

The `ftp:Client` connects to a given SFTP server, and then sends and receives files as byte streams. An `ftp:Client` with SFTP protocol is created by giving the protocol, host-name and required credentials and the private key. Once connected, `get` method is used to read files as byte streams from the SFTP server. Use this to transfer files from a remote file system to a local file system.

::: code sftp_client_receive_file.bal :::

## Prerequisites
- Start a [SFTP server](https://hub.docker.com/r/atmoz/sftp/) instance.
- Run the SFTP client given in the [SFTP client - Send file](/learn/by-example/sftp-client-send-file) example to put a file in the SFTP server.

Run the program by executing the following command. The newly-added file will appear in the local directory.

::: out sftp_client_receive_file.out :::

## Related links
- [`ftp:Client->get` method  - API documentation](https://lib.ballerina.io/ballerina/ftp/latest#Client#get)
- [SFTP client - Specification](/spec/ftp/#322-secure-client)
