# Client class

The `client` keyword is used with class definition to define client class. Ballerina supports defining client objects to allow a program to interact with remote network services. They are a special kind of objects that contain `remote` and `resource` methods in addition to regular methods. It is a compile-time error to have `remote` or `resource` methods in the regular class definition.

Similarly class objects can be constructed using object constructor as well.

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

::: code client_class.bal :::

Run the client program by executing the following command.

::: out client_class.out :::

## Related links
- [Resource methods](/learn/by-example/resource-methods/)
- [Defining classes](/learn/by-example/defining-classes/)
- [Object types](/learn/by-example/object-types/)
