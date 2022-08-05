# Object mocking

Object mocking enables controlling the values of member variables and the behavior of
the member functions of an object. Mocking of objects can be done in two ways.
1. Creating a test double - providing an equivalent mock object in place of the real
2. Stubbing the member function or member variable - stubbing the behavior of functions
and values of variables

Creating a test double is suitable when a single mock function/object can be used
throughout all tests whereas stubbing is ideal when defining different behaviors for
different test cases is required.

For more information, see [Test ballerina code](https://ballerina.io/learn/test-ballerina-code/test-quick-start/)
and the [`test` module](https://docs.central.ballerina.io/ballerina/test/latest/).

::: code testerina_mocking_objects_main.bal :::

::: code testerina_mocking_objects_test.bal :::

::: out testerina_mocking_objects_test.out :::
