# Isolated objects

An object defined as `isolated` is similar to a module with `isolated` module-level variables.
Mutable fields of an `isolated` object,
<ul>
<li>must be `private` and so can only be accessed using `self`</li>
<li>must be initialized with an `isolated` expression</li>
<li>must only be accessed within a `lock` statement</li>
<li>`lock` statement must follow the same rules for `self` as for an `isolated` variable</li>
<li>a field is mutable unless it is `final` and has a type that is a subtype of `readonly`</li>
</ul>
<br></br>
<p>Isolated root concept treats `isolated` objects as opaque. Isolated functions can access a `final`
variable whose type is an `isolated` object.</p>

::: code isolated_objects.bal :::

::: out isolated_objects.out :::