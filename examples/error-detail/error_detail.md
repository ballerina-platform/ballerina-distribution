# Error detail

Error detail is a map that contains arbitrary extra details about the context of the error. Type `error<T>` describes an error value with a detail map that has type `T`. Named arguments for the error constructor specifies the fields of the detail record. An immutable copy is made of each field of the detail record using the `cloneReadOnly` function.

::: code type_inference.bal :::

::: out type_inference.out :::