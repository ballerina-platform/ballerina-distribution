# Object type inclusion

Object type inclusion enables two things. Firstly, it allows the creation of an object type that includes another object type such that one interface extends another interface. Secondly, it allows creating a class that includes a type like the class implementing the interface. You can include object types using the `*T` syntax.

The implementation of the object type within the class that includes the type is checked at the compile time. This provides interface inheritance. Ballerina does not support implementation inheritance.

::: code object_type_inclusion.bal :::

::: out object_type_inclusion.out :::