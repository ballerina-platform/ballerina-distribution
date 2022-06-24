# Decimal type

The `decimal` type is the third numeric type. It works like `int` and `float` types.
It is a separate basic type and belongs to the `anydata` type.
There is no implicit conversions between `decimal` and other numeric types.
It can represent `decimal` fractions exactly and it preserves precision.
The `decimal` type does not include infinity, NaN, or negative zero.
It supports floating-point precision to 34 decimal digits.

::: code decimal_type.bal :::

::: out decimal_type.out :::