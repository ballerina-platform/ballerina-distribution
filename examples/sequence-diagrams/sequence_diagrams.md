# Sequence diagrams

A function can be viewed as a sequence diagram as shown below.
![Sequence Diagrams](/learn/by-example/images/sequence-diagram.png "Sequence Diagram")
The diagram has a lifeline (vertical line) for each worker (both named worker and function's default worker). The diagram also has a lifeline for each client object parameter or variable in the initialization section, representing the remote system to which the client object is sending messages. Each remote method call on a client object is represented as a horizontal line between the lifeline of the worker making the call and the remote system.

::: code sequence_diagrams.bal :::

::: out sequence_diagrams.out :::