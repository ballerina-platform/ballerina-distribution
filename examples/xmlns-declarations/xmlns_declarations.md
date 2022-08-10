# XMLNS declarations

The `xmlns` declarations are like import declarations, but bind the prefix to a namespace URL rather than
a module. The `xmlns` declarations in the Ballerina module provide namespace context for parsing `xml`
templates. The Qualified names in Ballerina modules are expanded into `strings` using the `xmlns`
declarations in the module. The `xmlns` declarations are also allowed at block level.

::: code xmlns_declarations.bal :::

::: out xmlns_declarations.out :::