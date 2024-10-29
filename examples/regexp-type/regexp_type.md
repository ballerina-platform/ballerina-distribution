# RegExp type

`RegExp` is a built-in type in Ballerina that represents a regular expression. Regular expressions are commonly used for tasks such as validating input, searching and replacing text, and parsing data.

The `RegExp` type is defined in the `lang.regexp` module, and can also be referenced using the type alias named the same in the `lang.string` module. The `RegExp` type conforms to a subset of the ECMAScript specification for regular expressions.

A `RegExp` value can be created by using the regexp template expression or calling the [`fromString` method of the lang.regexp](https://lib.ballerina.io/ballerina/lang.regexp/latest#fromString) module. 

::: code regexp_type.bal :::

::: out regexp_type.out :::

## Related links
- [Ballerina regular expression grammar](https://ballerina.io/spec/lang/master/#section_10.1)
- [RegExp langlib functions overview](/learn/by-example/regexp-operations-overview)
- [RegExp API Docs](https://lib.ballerina.io/ballerina/lang.regexp)
- [string API Docs](https://lib.ballerina.io/ballerina/lang.string)
