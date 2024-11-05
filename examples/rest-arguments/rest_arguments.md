# Rest arguments

Ballerina allows you to call functions with rest arguments, with an expression of a mapping or list type, spreading the members of the mapping or the list as individual arguments to the function.

If the type of the expression used in the rest argument is a list type, the rest argument is equivalent to specifying each member of the list value as a positional argument. If it is a mapping type, the rest argument is equivalent to specifying each field of the mapping value as a named argument, where the name and the value of the named argument come from the name and the value of the field. In either case, the static type of the expression must ensure that the equivalent positional and/or named arguments would be valid and that arguments are provided for all the required parameters.
 
::: code rest_arguments.bal :::

::: out rest_arguments.out :::

## Related links
- [Functions](/learn/by-example/functions/)
- [Provide function arguments by name](/learn/by-example/provide-function-arguments-by-name/)
- [Included record parameters](/learn/by-example/included-record-parameters/)
- [Aggregation](/learn/by-example/aggregation/)
