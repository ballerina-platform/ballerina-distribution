# Readonly Objects and Classes

An object is `readonly` if all of its fields are `final` and are of types that are subtypes of the `readonly` type. Object `T` can be declared as readonly with `readonly & T`.
A class that belongs to the `readonly` type can be declared by prefixing the `readonly` keyword in the class declaration.

::: code readonly_objects_and_classes.bal :::

::: out readonly_objects_and_classes.out :::