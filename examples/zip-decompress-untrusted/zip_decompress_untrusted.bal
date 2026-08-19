import ballerina/io;
import ballerina/zip;

public function main() returns error? {
    // Cap what the extraction is allowed to cost, so an archive built to
    // exhaust the disk is stopped rather than unpacked. An absent limit is no
    // limit.
    zip:DecompressOptions options = {
        limits: {
            maxEntries: 2,
            maxTotalSize: 10 * 1024 * 1024,
            maxCompressionRatio: 100
        }
    };
    zip:Error? result = zip:decompress("reports.zip", "unpacked", options);

    // The error type tells a hostile archive from a broken one. An entry whose
    // name would write outside the target directory is refused in the same way,
    // with an `UnsafePathError`.
    if result is zip:LimitExceededError {
        io:println("Refused: ", result.message());
    } else if result is zip:UnsafePathError {
        io:println("Refused: an entry writes outside the target directory");
    } else {
        check result;
        io:println("Unpacked reports.zip");
    }
}
