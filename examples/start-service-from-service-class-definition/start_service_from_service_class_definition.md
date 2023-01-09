# Start service from service class definition

The `service` keyword is used with the class definition to define a service class. A service object can be constructed from a service class. A service object supports network interaction with a remote system that is originated by the remote system. They are a special kind of object that contain `remote` and `resource` methods in addition to regular methods.

The `Listener` object receives network input and makes calls to remote methods of attached service objects. 
The example below demonstrates how to start the service from its class definition.

::: code start_service_from_service_class_definition.bal :::

Run the service as follows.

::: out start_service_from_service_class_definition.service.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out start_service_from_service_class_definition.client.out :::

## Related links
- [Dynamic listener](/learn/by-example/dynamic-listener/)
- [Object type inclusion](/learn/by-example/object-type-inclusion/)
- [Client class](/learn/by-example/client-class/)
