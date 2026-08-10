# Excel workbooks in memory

The Ballerina `xlsx` library can build, serialize, and load Excel workbooks entirely in memory as byte arrays, without touching the file system. This suits integration scenarios where workbooks arrive as service payloads or are produced for download responses.

::: code xlsx_workbook_in_memory.bal :::

::: out xlsx_workbook_in_memory.out :::
