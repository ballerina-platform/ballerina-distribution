# Providing services

Providing services involves the interaction of three main things <br/><br/>
//
1) Service objects are the counterpart of client objects. Service objects also have remote methods and they are remotely accessible to clients.
Remote method of a client object typically calls the remote method of a service object.
//
2) Listener is the entity that receives the network input and then it makes calls to remote methods of attached service objects.
Listeners are registered with the module as illustrated in the following example.
//
3) Modules have a lifecycle and they are initialized on program startup. Modules start up the registered listeners after the initialization and
shut them down during the program shutdown.

::: code providing_services.bal :::

::: out providing_services.out :::