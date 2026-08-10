import ballerina/io;
import ballerina/xlsx;

public function main() returns error? {
    // Build a workbook entirely in memory and serialize it to bytes,
    // e.g., to send as a service payload without touching the disk.
    xlsx:Workbook wb = new;
    xlsx:Sheet inventory = check wb.createSheet("Inventory");
    check inventory.putRows([
        {"item": "Laptop", "stock": 12},
        {"item": "Monitor", "stock": 40}
    ]);
    byte[] content = check wb.toBytes();
    check wb.close();

    // Open a workbook received as a byte array, update a cell,
    // and read the new value back.
    xlsx:Workbook received = check xlsx:fromBytes(content);
    io:println(check received.getSheetNames());
    xlsx:Sheet sheet = check received.getSheet("Inventory");
    check sheet.setCellByAddress("B2", 10);
    xlsx:CellValue stock = check sheet.getCell(1, 1);
    io:println(stock);
    check received.close();
}
