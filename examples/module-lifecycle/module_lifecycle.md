# Module lifecycle

All modules are initialized at program startup. Module initialization is ordered so that if module A imports module B,
then module A is initialized after module B. The initialization phase ends by calling the `main` function if there is one. <br/><br/>
A module's listeners are registered during module initialization.
If there are registered listeners, then the initialization phase is followed by the listening phase. <br/><br/>
The listening phase starts by calling the `start` method on each registered listener. The listening phase is terminated by signal (e.g. `SIGINT`, `SIGTERM`).

::: code module_lifecycle.bal :::

::: out module_lifecycle.out :::