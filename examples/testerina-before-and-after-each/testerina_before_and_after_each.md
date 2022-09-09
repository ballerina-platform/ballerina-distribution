# Before and after each

The function specified with the `BeforeEach` annotation is executed before every test and the function specified with the `AfterEach` annotation is executed after every test within the test suite. This can be used for repeatedly initializing and tearing down test level aspects before every test function.

For more information, see [Testing Ballerina Code](https://ballerina.io/learn/test-ballerina-code/execute-tests/#understand-the-test-execution-behavior) and the [`test` module](https://lib.ballerina.io/ballerina/test/latest/).

::: code testerina_before_and_after_each.bal :::

::: out testerina_before_and_after_each.out :::
