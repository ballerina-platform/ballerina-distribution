# Group tests

You can tag your test cases with a single group name or multiple group names (one or more).
This allows you to control the execution of selected tests.<br/><br/>
In order to execute tests belonging to a selected test group, you can name the 
test groups that are to be executed when you run the tests.
Likewise, you can exclude executing the selected test groups as well.<br/><br/>
For more information, see [Testing Ballerina Code](https://ballerina.io/learn/testing-ballerina-code/testing-quick-start/)
and the [Test Module](https://docs.central.ballerina.io/ballerina/test/latest/).

::: code testerina_group_tests.bal :::

::: out testerina_group_tests.out :::

Run the tests belonging to the `g1` and `g2` groups

::: out testerina_group_tests_groups_g1_g2.out :::

Run the tests belonging to the `g1` group

::: out testerina_group_tests_groups_g1.out :::

Run all tests other than the tests belonging to the `g2` group

::: out testerina_group_tests_disable_groups.out :::
