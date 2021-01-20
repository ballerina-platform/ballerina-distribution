import ballerina/io;

public function main() returns @tainted error? {
    // Initialize the JSON file path and content.
    string jsonFilePath = "./files/jsonFile.json";
    json jsonContent = {"Store": {
            "@id": "AST",
            "name": "Anne",
            "address": {
                "street": "Main",
                "city": "94"
            },
            "codes": ["4", "8"]
        }};

    // Write the given JSON to a file.
    check io:fileWriteJson(jsonFilePath, jsonContent);
    // If the write operation was successful, then, perform a read operation to read the JSON content.
    json readJson = check io:fileReadJson(jsonFilePath);
    io:println(readJson);
}
