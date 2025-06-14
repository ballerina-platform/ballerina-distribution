# Arrays

An array can be used to hold a set of values of the same type. The array type can be defined as `T[n]` in which `T` is the element type and `n` is the length of the array. `n` must be an integer literal or constant reference of type `int`. Optionally, you can create a variable-length array by defining an array without `n` as `T[]`.

The length of the array can be inferred from the context by defining the array as `T[*]`. The length of the array should be known in compile time.

# Quick Comparison of Array Types in Ballerina

| **Type**             | **Declaration Syntax** | **Example Syntax**                  | **Length Known at Compile Time** | **Resizable** |
|----------------------|------------------------|-------------------------------------|----------------------------------|---------------|
| Fixed-length array   | `T[n] <arrayName>`               | `int[3] nums = [1, 2, 3];`          | ✅ Yes                           | ❌ No         |
| Variable-length      | `T[] <arrayName>`                | `int[] even = [2, 4];`           | ❌ No                            | ✅ Yes        |
| Inferred-length      | `T[*] <arrayName>`            | `string[*] colors = ["red"];`       | ✅ Yes                           | ❌ No         |

> 📌 **Note**:
> - `T` represents any valid data type (e.g., `int`, `string`, `float`, etc.)
> - `n` represents the exact number of elements the array must have. 
> - Fixed-length and inferred-length arrays cannot change their size once initialized.  
> - Variable-length arrays (also known as open arrays) allow dynamic resizing using methods like `.push()` and `.remove()`.


::: code arrays.bal :::

::: out arrays.out :::

## Related links
- [Manipulating an array `(lang.array)`](https://lib.ballerina.io/ballerina/lang.array)
- [Tuples](/learn/by-example/tuples)
- [Nested arrays](/learn/by-example/nested-arrays)
- [Filler values of a list](/learn/by-example/filler-values-of-a-list)
- [List sub typing](/learn/by-example/list-subtyping)
- [List equality](/learn/by-example/list-equality)
