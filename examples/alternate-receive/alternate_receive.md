# Alternate receive

The alternate receive action can be used to receive values from multiple send actions. It operates by waiting until it encounters a non-error message, a panic termination status on a closed channel, or the closure of all channels. Alternate receive action sets the first non-error value it encounters as the outcome.

::: code alternate_receive.bal :::

::: out alternate_receive.out :::
