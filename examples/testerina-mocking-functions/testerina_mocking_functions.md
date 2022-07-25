# Function mocking

Mock functions allow you to hide the real function implementation and engage your own definition when running tests.
This allows you to isolate your tests from the other modules and functions.

Function mocks can be stubbed with return values or with another user-defined function,
which has the same signature as the original function. 
Function mocking is not supported for testing single `.bal` files.

For more information, see [Test ballerina code](https://ballerina.io/learn/test-ballerina-code/test-quick-start/)
and the [`test` module](https://docs.central.ballerina.io/ballerina/test/latest/).

::: code testerina_mocking_functions_main.bal :::

::: code testerina_mocking_functions_test.bal :::

::: out testerina_mocking_functions_test.out :::
