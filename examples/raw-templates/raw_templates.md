# Raw templates

A raw template is a backtick template without a tag. Exposes result of phase 1 without further processing.
Raw template is evaluated by evaluating each expression and creating an object containing.
<ul>
<li>an `array` of the `strings` separated by insertions</li>
<li>an `array` of the results of expression evaluation and an `array` of `strings` separating</li>
</ul>
//<br></br>
<p>Important use case: SQL parameters.</p>
Note that the relevant database driver JAR should be defined in the `Ballerina.toml` file as a dependency.
This sample is based on an H2 database and the H2 database driver JAR need to be added to `Ballerina.toml` file.
For a sample configuration and more information on the underlying module, see the [JDBC module](https://docs.central.ballerina.io/ballerinax/java.jdbc/latest/) .<br><br>
This sample is written using H2 2.1.210 and it is recommended to use H2 JAR with versions higher than 2.1.210.

::: code raw_templates.bal :::

::: out raw_templates.out :::