# Function mocking

Mock functions allow you to hide the real function implementation and engage your own definition when running tests. This allows you to isolate your tests from the other modules and functions.

Function mocks can be stubbed with return values or with another user-defined function, which has the same signature as the original function.

For more information, see [Testing Ballerina Code](https://ballerina.io/learn/testing-ballerina-code/testing-quick-start/) and the [Test Module](https://lib.ballerina.io/ballerina/test/latest/).

::: code testerina_mocking_functions_main.bal :::

::: code testerina_mocking_functions_test.bal :::

::: out testerina_mocking_functions_test.out :::
