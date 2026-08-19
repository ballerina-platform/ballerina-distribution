import ballerina/file;
import ballerina/io;
import ballerina/zip;

public function main() returns error? {
    check file:createDir("reports");
    check io:fileWriteString("reports/notes.txt",
            "The regional totals are provisional until the audit closes.");
    check zip:compress("reports", "reports.zip", {overwrite: true});

    // Unpack every entry into the target directory, which is created when it is
    // missing. `fileWriteMode` decides what becomes of a file already sitting
    // where an entry unpacks to, and `limits` caps what the extraction is
    // allowed to cost.
    zip:DecompressOptions options = {fileWriteMode: zip:REPLACE};
    check zip:decompress("reports.zip", "restored", options);

    string notes = check io:fileReadString("restored/reports/notes.txt");
    io:println(notes);
}
