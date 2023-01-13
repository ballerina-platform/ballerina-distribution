# Visibility of object fields and methods

The visibility of each field and method of an object in Ballerina can be set to `private`, `public`, or default (without a visibility qualifier).

- If the visibility is set to `private`, the field or method is only accessible within the `class` definition.
- If the visibility is set to `public`, the field or method is accessible outside the module as well.
- If the visibility is set to default (no visibility qualifier), the field or method is only accessible within the module.

Attempting to access a private field or method from outside the class definition will result in a compile-time error.

::: code visibility_of_object_fields_and_methods.bal :::

::: out visibility_of_object_fields_and_methods.out :::

## Related links
- [Objects](/learn/by-example/objects/)
- [Defining classes](/learn/by-example/defining-classes/)
- [Object value from class definition](/learn/by-example/object-value-from-class-definition/)
