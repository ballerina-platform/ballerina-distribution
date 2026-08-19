import ballerina/file;
import ballerina/io;
import ballerina/zip;

public function main() returns error? {
    check file:createDir("reports");
    check io:fileWriteString("reports/region-totals.csv",
            "region,quarter,total\nEMEA,Q1,4820\nAPAC,Q1,3915\nAMER,Q1,5210\n");
    check io:fileWriteString("reports/notes.txt",
            "Compiled for the August review. The regional totals are " +
            "provisional until the audit closes.\n");
    check zip:compress("reports", "reports.zip", {overwrite: true});

    // Read what the archive holds without unpacking it. The entries come back
    // in the order they are stored, directories included, each carrying the
    // sizes, the compression method, the modified time, and the CRC-32 of the
    // content.
    zip:Entry[] entries = check zip:listEntries("reports.zip");
    foreach zip:Entry entry in entries {
        io:println(entry.name, ": ", entry.uncompressedSize, " -> ",
                entry.compressedSize, " bytes (", entry.method, ")");
    }
}
