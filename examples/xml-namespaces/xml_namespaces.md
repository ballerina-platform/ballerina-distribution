# XML namespaces

The `ns:x` qualified name in XML is expanded into `{url}x` where `url` is the namespace name bound to `ns`. The XML namespace declarations are kept as attributes using the standard binding of [xmlns](http://www.w3.org/2000/xmlns/).

XML namespaces are supported in such a way that they do not add complexity if you do not use them. 

::: code xml_namespaces.bal :::

::: out xml_namespaces.out :::
