# Error detail

Error detail is a map that contains arbitrary extra details about the context of the error. The `error<T>` type describes an error value with a detail map that has the type `T`. Named arguments of the error constructor specify the fields of the detail record. An immutable copy of each field is made in the detail record using the `cloneReadOnly` function.

::: code type_inference.bal :::

::: out type_inference.out :::