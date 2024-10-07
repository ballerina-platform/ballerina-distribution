# Panics

Ballerina distinguishes normal errors from abnormal errors. Normal errors are handled by returning error values. This signals to the caller that they must handle the error. In contrast, abnormal errors such as division by 0 and out-of-memory are typically unrecoverable errors and we need to terminate the execution of the program. This is achieved by a panic statement, which expects an expression that results in an error value such as the error constructor. At runtime evaluating a panic statement first create the error value by evaluating the expression and then start stack unwinding. In this process, if it comes across a trap expression it stops further unwinding and as a result of that trap expression, you will get the error created at the panic statement. 

::: code panics.bal :::

::: out panics.out :::
