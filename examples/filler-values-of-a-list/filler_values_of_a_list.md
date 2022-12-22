# Filler values of a list

Lists can be initialized with the help of filler values. These are the default values that a list member will be initialized with if the user does not provide a value in the list constructor. This gives you the flexibility to assign the actual values later for lists.

::: code updating_a_list.bal :::

::: out updating_a_list.out :::

## Filler values table

<table>
<tr>
<th>Type descriptor</th>
<th>Filler value</th>
<th>When available</th>
</tr>
<tr>
<td><code>()</code></td>
<td><code>()</code></td>
<td></td>
</tr>
<tr>
<td><code>boolean</code></td>
<td><code>false</code></td>
<td></td>
</tr>
<tr>
<td><code>int</code></td>
<td><code>0</code></td>
<td></td>
</tr>
<tr>
<td><code>float</code></td>
<td><code>+0.0f</code></td>
<td></td>
</tr>
<tr>
<td><code>decimal</code></td>
<td><code>+0d</code></td>
<td></td>
</tr>
<tr>
<td><code>string</code></td>
<td><code>""</code></td>
<td></td>
</tr>
<tr>
<td>array or tuple type descriptor</td>
<td><code>[]</code></td>
<td>if that is a valid constructor for the type</td>
</tr>
<tr>
<td>map or record type descriptor</td>
<td><code>{ }</code></td>
<td>if that is a valid constructor for the type</td>
</tr>
<tr>
<td><code>readonly &amp; T</code></td>
<td>the filler value for T constructed as read-only</td>
<td>if that belongs to the type</td>
</tr>
<tr>
<td>table</td>
<td>empty table (with no rows)</td>
<td></td>
</tr>
<tr>
<td>object</td>
<td><code>new T()</code></td>
<td>if T is a class, where T is the type descriptor for the object, and the
static type of T's init method allows no arguments and does not include error</td>
</tr>
<tr>
<td>stream</td>
<td>empty stream</td>
<td></td>
</tr>
<tr>
<td><code>xml</code></td>
<td><code>xml``</code></td>
<td></td>
</tr>
<tr>
<td>built-in subtype of <code>xml</code></td>
<td><code>xml``</code></td>
<td>if this belongs to the subtype, i.e. if the subtype is
<code>xml:Text</code></td>
</tr>
<tr>
<td>singleton</td>
<td>the single value used to specify the type</td>
<td></td>
</tr>
<tr>
<td rowspan="2">union</td>
<td><code>()</code></td>
<td>if <code>()</code> is a member of the union</td>
</tr>
<tr>
<td>the filler value for basic type B</td>
<td>if all members of the union belong to a single basic type B,
and the filler value for B also belongs to the union</td>
</tr>
<tr>
<td><code>T?</code></td>
<td><code>()</code></td>
<td></td>
</tr>
<tr>
<td><code>any</code></td>
<td><code>()</code></td>
<td></td>
</tr>
<tr>
<td><code>anydata</code></td>
<td><code>()</code></td>
<td></td>
</tr>
<tr>
<td><code>byte</code></td>
<td><code>0</code></td>
<td></td>
</tr>
<tr>
<td>built-in subtype of <code>int</code></td>
<td><code>0</code></td>
<td></td>
</tr>
<tr>
<td><code>json</code></td>
<td><code>()</code></td>
<td></td>
</tr>
</table>

## Related links
- [Tuples - Ballerina by example](https://ballerina.io/learn/by-example/tuples)
- [Arrays - Ballerina by example](https://ballerina.io/learn/by-example/arrays)
- [Nested arrays - Ballerina by example](https://ballerina.io/learn/by-example/nested-arrays)
