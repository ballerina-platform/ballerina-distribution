import ballerina/io;
import ballerina/zip;

public function main() returns error? {
    // Archive the directory of reports. `level` trades speed against size, and
    // `overwrite` replaces an archive already sitting at the target path. The
    // source directory becomes the root entry, so every entry is named
    // `reports/...`, unless `includeSourceDirectory` is set to false.
    zip:CompressOptions options = {level: zip:BEST, overwrite: true};
    check zip:compress("resources/reports", "reports.zip", options);
    io:println("Created reports.zip");
}
