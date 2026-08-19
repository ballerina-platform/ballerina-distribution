import ballerina/io;
import ballerina/zip;

public function main() returns error? {
    // Read what the archive holds without unpacking it. The entries come back
    // in the order they are stored, directories included, each carrying the
    // sizes, the compression method, the modified time, and the CRC-32 of the
    // content.
    zip:Entry[] entries = check zip:listEntries("reports.zip");
    foreach zip:Entry entry in entries {
        io:print(string `${entry.name}: ${entry.uncompressedSize} -> `);
        io:println(string `${entry.compressedSize} bytes (${entry.method})`);
    }

    // Unpack every entry into the target directory, which is created when it is
    // missing. `fileWriteMode` decides what becomes of a file already sitting
    // where an entry unpacks to, and `limits` caps what the extraction is
    // allowed to cost.
    zip:DecompressOptions options = {fileWriteMode: zip:REPLACE};
    check zip:decompress("reports.zip", "restored", options);

    // Read one of the unpacked files.
    string notes = check io:fileReadString("restored/reports/notes.txt");
    io:println(notes);
}
