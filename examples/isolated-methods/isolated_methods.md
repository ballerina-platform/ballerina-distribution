# Isolated methods

Object methods can be `isolated`. An `isolated` method is same as an `isolated` function with `self` treated as a parameter. An `isolated` method call is concurrency-safe if both the object is safe and the arguments are safe. This is not quite enough for service concurrency. When a `listener` makes calls to a `remote` or `resource` method,

- it can ensure the safety of arguments it passes
- it has no way to ensure the safety of the object itself (since the object may have fields)

::: code isolated_methods.bal :::

Executing the above code gives the output below.

::: out isolated_methods.out :::