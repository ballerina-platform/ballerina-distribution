# Interface to exteral code

Ballerina supports interfacing to external code. This can be done by using the `external` keyword, instead of implementing the function body. The implementation figures out how to map to the external implementation. As part of interfacing to an external implementation, Ballerina supports another basic type called `handle`. The `handle` type is basically an opaque handle that can be passed to and from external functions. There is no typing for `handle` and it can be added as a private member of a Ballerina class for better type safety.

::: code interface_to_external_code.bal :::

::: out interface_to_external_code.out :::