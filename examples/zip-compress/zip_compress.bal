import ballerina/file;
import ballerina/io;
import ballerina/zip;

public function main() returns error? {
    // Create the directory of reports to archive.
    check file:createDir("reports");
    check io:fileWriteString("reports/region-totals.csv",
            "region,quarter,total\nEMEA,Q1,4820\nAPAC,Q1,3915\nAMER,Q1,5210\n");
    check io:fileWriteString("reports/notes.txt",
            "Compiled for the August review. The regional totals are " +
            "provisional until the audit closes.\n");

    // Archive the directory. `level` trades speed against size, and `overwrite`
    // replaces an archive already sitting at the target path. The source
    // directory becomes the root entry, so every entry is named `reports/...`,
    // unless `includeSourceDirectory` is set to false.
    zip:CompressOptions options = {level: zip:BEST, overwrite: true};
    check zip:compress("reports", "reports.zip", options);
    io:println("Created reports.zip");
}
