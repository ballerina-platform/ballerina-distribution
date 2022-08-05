# XMLNS declarations

`xmlns` declarations are like import declarations but they bind the prefix to a namespace URL rather than a module. 

`xmlns` declarations in a Ballerina module provide namespace contexts for parsing `xml` templates. Qualified names in Ballerina modules are expanded into strings using the `xmlns` declarations in the module. 

`xmlns` declarations are also allowed at block level.

::: code xmlns_declarations.bal :::

::: out xmlns_declarations.out :::