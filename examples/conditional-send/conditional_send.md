# Conditional send

The send action in workers can be used in a conditional context, allowing for more flexible and dynamic inter-worker communication based on specific conditions. The receiver side in a conditional send might not always receive a message. Thus, to handle such scenarios, the static type of the receive action includes the `error:NoMessage` type.

::: code conditional_send.bal :::

::: out conditional_send.out :::
