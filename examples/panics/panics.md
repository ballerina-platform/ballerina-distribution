# Panics

Ballerina distinguishes normal errors from abnormal errors. Normal errors are handled by returning error values. This signals to the caller that they must handle the error. In contrast, abnormal errors such as division by 0 and out-of-memory are typically unrecoverable errors and we need to terminate the execution of the program. This is achieved by a panic statement with an expression that results in an error value such as the error constructor. At runtime, evaluating a panic statement first creates the error value by evaluating the expression and then starts stack unwinding, unless it encounters a `trap` expression. 

::: code panics.bal :::

::: out panics.out :::
