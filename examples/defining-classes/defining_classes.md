# Defining classes

Classes provide a template for bundling data and functionality together. In Ballerina, classes are defined at the module level. The `init` method is used to initialize an object and any arguments passed to the `new` expression are passed as arguments to the `init` method. The `init` method can also be used to initialize the `final` fields.

The `self` variable is bound to the object and can be used to access the fields and methods of the object.

::: code defining_classes.bal :::

::: out defining_classes.out :::

## Related links
- [Object](/learn/by-example/object/)
- [Init return type](/learn/by-example/init-return-type/)
- [Object values](/learn/by-example/object-values/)
