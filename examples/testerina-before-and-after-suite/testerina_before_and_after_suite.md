# Before and after suite

The `BeforeSuite` annotation allows you to execute a function before executing a test suite.
Similarly, the `AfterSuite` annotation can be used to execute a function after a test suite.<br/><br/>
A module is considered as a suite in the Test framework. <br></br>
These annotations can be used to set up prerequisites and post actions for a test suite.
For more information, see [Testing Ballerina Code](https://ballerina.io/learn/testing-ballerina-code/testing-quick-start/)
and the [Test Module](https://docs.central.ballerina.io/ballerina/test/latest/).

::: code testerina_before_and_after_suite.bal :::

::: out testerina_before_and_after_suite.out :::