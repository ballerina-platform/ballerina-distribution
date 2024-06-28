# Alternate receive

The alternate receive action can be used to receive one of multiple values corresponding to multiple send actions. It operates by waiting until it encounters a non-error message, a panic termination status on a closed channel, or the closure of all channels. Alternate receive action sets the first non-error value it encounters as the result.

::: code alternate_receive.bal :::

::: out alternate_receive.out :::
