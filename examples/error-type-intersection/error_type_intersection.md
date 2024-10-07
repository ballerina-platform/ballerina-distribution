# Type intersection for error types

If you intersect two `error` types, the resulting type's detail type is the intersection of the detail types of both types. Furthermore, if any of the types being intersected is a distinct type, then the resultant type's type ID set includes all the type IDs of that type.

::: code error_type_intersection.bal :::

::: out error_type_intersection.out :::
