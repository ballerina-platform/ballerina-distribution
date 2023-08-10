# Object type inclusion

Object type inclusion enables two things. Firstly, it allows the creation of an object type that includes another object type such that one interface extends another interface. Secondly, it allows creating a class that includes a type like the class implementing the interface. You can include object types using the `*T` syntax.

The implementation of the object type within the class that includes the type is checked at the compile time.

::: code object_type_inclusion.bal :::

::: out object_type_inclusion.out :::

## Related links
- [Object types](/learn/by-example/object-types/)
- [Defining classes](/learn/by-example/defining-classes/)
- [Type inclusion for records](/learn/by-example/type-inclusion-for-records/)
