# Run strands safely on a separate thread based on isolation

Ballerina extended the isolated feature to identify cases in which strands created by a start action, or a named worker can be run safely on separate threads.

A start action is isolated if the function or method it calls has a type that is isolated and the expression for every argument is an isolated expression. An isolated start action is allowed in an isolated function and the strand created by the start action will run in a separate thread from the current thread.

The strand created by a named worker can run on a separate thread from the default worker if the body of the worker satisfies the requirements for an isolated function.

::: run_strands_safely_on_separate_threads.bal :::

::: run_strands_safely_on_separate_threads.out :::
