# Directory listener

The `file` library provides a `Directory Listener`, which is used to listen to the given directory in the local file system.
It notifies when new files are created in the directory or when the existing files are deleted or modified.

For more information on the underlying module, see the [`file` module](https://lib.ballerina.io/ballerina/file/latest/).

Before running this, change the value of the 'path' field to indicate the path of the directory that you want to monitor. 
As the recursive property is set to false, the listener does not monitor the child directories of the main directory that it listens to.

::: code directory_listener.bal :::

To run this sample, use the `bal run` command.

::: out directory_listener.out :::