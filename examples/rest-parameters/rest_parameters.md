# Rest Parameters

Ballerina supports rest parameters. There can not be another parameter after a rest parameter. 
If a function has a rest parameter, that is initialized to a newly created list with the remaining arguments in the function.
The inherent type of this list is `T[]` in which `T` is the type of the rest parameter.

::: code rest_parameters.bal :::

::: out rest_parameters.out :::