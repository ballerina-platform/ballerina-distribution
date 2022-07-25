# Before and after suite

The `BeforeSuite` annotation allows you to execute a function before executing a test suite.
Similarly, the `AfterSuite` annotation can be used to execute a function after a test suite.
A module is considered as a suite in the test framework.

For more information, see [Test ballerina code](https://ballerina.io/learn/test-ballerina-code/test-quick-start/)
and the [`test` module](https://docs.central.ballerina.io/ballerina/test/latest/).

These annotations can be used to set up the prerequisites and post actions for a test suite.

::: code testerina_before_and_after_suite.bal :::

::: out testerina_before_and_after_suite.out :::
