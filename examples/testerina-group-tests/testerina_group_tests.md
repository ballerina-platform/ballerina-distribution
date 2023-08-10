# Group tests

You can tag your test cases with a single group name or multiple group names (one or more). This allows you to control the execution of selected tests.

In order to execute tests belonging to a selected test group, you can name the  test groups that are to be executed when you run the tests.

Likewise, you can exclude executing the selected test groups as well.

For more information, see [Testing Ballerina Code](https://ballerina.io/learn/test-ballerina-code/define-test-groups/) and the [`test` module](https://lib.ballerina.io/ballerina/test/latest/).

::: code testerina_group_tests.bal :::

Run the tests belonging to the `g1` and `g2` groups.

::: out testerina_group_tests_groups_g1_g2.out :::

Run the tests belonging to the `g1` group.

::: out testerina_group_tests_groups_g1.out :::

Run all tests other than the tests belonging to the `g2` group.

::: out testerina_group_disable_groups.out :::
