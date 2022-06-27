# Anydata type

The type for plain data is `anydata` which is a subtype of `any`. 

Operators `==` and `!=` test for deep equality. [x.clone()](https://lib.ballerina.io/ballerina/lang.value/0.0.0/functions#clone) returns a deep copy with the same mutability. [x.cloneReadOnly()](https://lib.ballerina.io/ballerina/lang.value/0.0.0/functions#cloneReadOnly) returns a deep copy that is immutable. Ballerina syntax uses `readonly` to mean immutable. Both `x.clone()` and `x.cloneReadOnly()` do not copy immutable parts of `x`. Ballerina also allows `const` structures.

Equality and cloning handle cycles.

::: code anydata_type.bal :::

::: out anydata_type.out :::