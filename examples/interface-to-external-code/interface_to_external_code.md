# Interface to exteral code

Ballerina supports interface with external code. Instead of implementing the function body the keyword `external` can be used. The implementation figures out how to map to the external implementation. As part of interfacing with external implementation, Ballerina supports another basic type called `handle`. The `handle` type is basically an opaque handle that can be passed to external functions. There is no typing for `handle` and it can be added as a private member of a Ballerina class for better type safety.

::: code interface_to_external_code.bal :::