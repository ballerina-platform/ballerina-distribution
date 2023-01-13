# Filler values of a list

Lists can be initialized with the help of filler values. These are the default values that a list member will be initialized with if you do not provide a value in the list constructor. This gives you the flexibility to assign the actual values later for lists.

::: code filler_values_of_a_list.bal :::

::: out filler_values_of_a_list.out :::

## Filler values table

Type descriptor                | Filler value                                      | When available
---------------                | ------------                                      | ---------------
`()`                           | `()` 	                                           |
`boolean`                      | `false` 	                                       |
`int`                          | `0` 	                                           |
`float`                        | `+0.0f` 	                                       |
`decimal`                      | `+0d` 	 	                                       |
`string`                       | `""` 	                                           |
array or tuple type descriptor | `[]` 	                                           | if that is a valid constructor for the type
map or record type descriptor  | `{}` 	                                           | if that is a valid constructor for the type
`readonly & T`                 | the filler value for `T` constructed as read-only | if that belongs to the type
`table`                        | empty table (with no rows) 		               |
`object`                       | `new T()` 	                                       | if `T` is a class, where `T` is the type descriptor for the object, and the static type of `T`'s init method allows no arguments and does not include error
`stream`                       | empty stream 		                               |
`xml`                          | ` xml`` `		                                   |
built-in subtype of xml        | ` xml`` ` 	                                       | if this belongs to the subtype, i.e. if the subtype is `xml:Text`
singleton                      | the single value used to specify the type 		   |
union                          | `()` 	                                           | if `()` is a member of the union |
union                          | the filler value for basic type `B` 	           | if all members of the union belong to a single basic type `B`, and the filler value for `B` also belongs to the union
`T?`                           | `()` 		                                       |
`any`                          | `()` 		                                       |
`anydata`                      | `()` 		                                       |
`byte`                         | `0` 		                                       |
built-in subtype of int 	   | `0` 		                                       |
`json` 	                       | `()` 	                                           |

## Related links
- [Tuples](/learn/by-example/tuples)
- [Arrays](/learn/by-example/arrays)
- [Nested arrays](/learn/by-example/nested-arrays)
