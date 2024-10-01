import ballerina/io;
import ballerina/lang.regexp;

public function main() {
    string[] productCodes = ["ELEC-1234", "FURN-5678", "CLOT-1111", "FOOD-3333"];

    // Regular expression to match and validate product codes.
    // Format: [PRODUCT_TYPE]-[UNIQUE_ID]
    string:RegExp productCodePattern = re `^([A-Z]{4})-(\d{4})$`;

    foreach string productCode in productCodes {
        // Check if the product code fully matches the expected format.
        boolean isValidProductCode = productCodePattern.isFullMatch(productCode);
        io:println(string `Product Code: ${productCode}, Valid: ${isValidProductCode}`);

        // If valid, extract the product type and unique ID from the match groups.
        regexp:Groups? matchGroups = productCodePattern.fullMatchGroups(productCode);
        if matchGroups is regexp:Groups {
            // The first element in the `matchGroups` is the entire matched string.
            // The subsequent elements in `matchGroups` represent the captured groups
            // (productType, uniqueID).
            string productType = (<regexp:Span>matchGroups[1]).substring();
            string uniqueID = (<regexp:Span>matchGroups[2]).substring();

            io:println(string `Product Type: ${productType}`);
            io:println(string `Unique ID: ${uniqueID}`);
        }
    }

    // Match product code from a specific starting index in the string.
    regexp:Span? productCode = productCodePattern.matchAt("Product code: FURN-5678", 14);
    if productCode is regexp:Span {
        io:println(string `Matched product: ${productCode.substring()}`);
    }

    // Regular expression to extract production time (HH:MM) from a log string
    string:RegExp timePattern = re `([01][0-9]|2[0-3]):([0-5][0-9])`;

    // Find groups of the matching string from a specified starting index.
    regexp:Groups? timeMatchGroups = timePattern.matchGroupsAt("Production time: 14:35", 17);
    if timeMatchGroups is regexp:Groups {
        string hour = (<regexp:Span>timeMatchGroups[1]).substring();
        string minutes = (<regexp:Span>timeMatchGroups[2]).substring();
        io:println(string `Production hour: ${hour}`);
        io:println(string `Production minutes: ${minutes}`);
    }
}
