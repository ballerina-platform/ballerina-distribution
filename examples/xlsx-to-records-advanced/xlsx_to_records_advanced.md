# Parse Excel file to records - advanced

The Ballerina `xlsx` library supports customizing how sheet data binds to records. This example maps the `Employee Name` header with `@xlsx:Name`, matches `SALARY` to `salary` without case sensitivity, and reads only the first two data rows.

For more information on the underlying module, see the [xlsx module](https://lib.ballerina.io/ballerina/xlsx/latest/).

::: code xlsx_to_records_advanced.bal :::

::: out xlsx_to_records_advanced.out :::
