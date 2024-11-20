import ballerina/io;
import ballerina/lang.regexp;

public function main() returns error? {
    string[] productCodes = ["ELEC-1234", "FURN-5678", "CLOT-1111", "FOOD-3333", "BAR-123"];

    // Regular expression to match and validate product codes.
    // Format: [PRODUCT_TYPE]-[UNIQUE_ID]
    string:RegExp productCodePattern = re `^([A-Z]{4})-(\d{4})$`;

    foreach string productCode in productCodes {
        // Check if the product code fully matches the expected format.
        boolean isValidProductCode = productCodePattern.isFullMatch(productCode);
        io:println(string `Product Code: ${productCode}, Valid: ${isValidProductCode}`);

        // If the product code is invalid, skip further processing.
        if !isValidProductCode {
            continue;
        }

        // For a valid product code, extract the product type and unique ID from the match groups.
        regexp:Groups? matchGroups = productCodePattern.fullMatchGroups(productCode);
        if matchGroups is regexp:Groups {
            // The first member in the `matchGroups` tuple is the entire matched string.
            // The subsequent members represent the captured groups
            // corresponding to product type and unique ID respectively.
            io:println("Product Type: ",
                    (check matchGroups[1].ensureType(regexp:Span)).substring());
            io:println("Unique ID: ",
                    (check matchGroups[2].ensureType(regexp:Span)).substring());
        }
    }

    // Match product code from a specific starting index in the string.
    regexp:Span? productCode = productCodePattern.matchAt(
            "Product code: FURN-5678, Product code: CLOT-1234", 39);
    if productCode is regexp:Span {
        io:println("Matched product: ", productCode.substring());
    }

    // Regular expression to extract the time in the format `HH:MM` from a log string.
    string:RegExp timePattern = re `([01][0-9]|2[0-3]):([0-5][0-9])`;

    // Find groups of the matching string from a specified starting index.
    regexp:Groups? timeMatchGroups = timePattern.matchGroupsAt(
            "Production time: 14:35, Production time: 16:15", 41);
    if timeMatchGroups is regexp:Groups {
        string hour = (check timeMatchGroups[1].ensureType(regexp:Span)).substring();
        string minutes = (check timeMatchGroups[2].ensureType(regexp:Span)).substring();
        io:println("Production hour: ", hour);
        io:println("Production minutes: ", minutes);
    }
}
