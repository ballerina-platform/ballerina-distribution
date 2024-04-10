# Alternate receive

The alternate receive action can be used receive values from several workers. It waits until either a non-error message, a panic termination status on a closed channel, or closure of all channels. Alternate receive actions sets the first non-error value it encounters as the result.

::: code alternate_receive.bal :::

::: out alternate_receive.out :::
