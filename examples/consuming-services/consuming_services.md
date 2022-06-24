# Consuming services: client objects

Ballerina has a language construct called client objects. 
They are a special kind of objects that contain `remote` methods in addition to regular methods. 
`remote` methods are used to interact with a remote service. 
Applications typically do not need to write client classes, which are either provided by library modules or generated from some flavor of IDL.

::: code consuming_services.bal :::

::: out consuming_services.out :::