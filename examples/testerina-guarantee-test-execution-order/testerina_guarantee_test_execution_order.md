# Guarantee test execution order

The `dependsOn` attribute can be used to define a list of functions that the test 
function depends on. These functions will be executed before the execution of that test.<br/><br/>
This allows you to ensure that the tests are being executed in the expected order.<br/><br/>
For more information, see [Testing Ballerina Code](https://ballerina.io/learn/testing-ballerina-code/testing-quick-start/)
and the [Test Module](https://docs.central.ballerina.io/ballerina/test/latest/).

::: code testerina_guarantee_test_execution_order.bal :::

::: out testerina_guarantee_test_execution_order.out :::