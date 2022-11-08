import ballerina/io;
client "./graphql.config.yaml" as trevorblades;

public function main() returns error? {
    trevorblades:client graphqlClient = check new (serviceUrl = "https://countries.trevorblades.com/");

    // Execute the `CountryByCode` query.
    trevorblades:CountryByCodeResponse response = check graphqlClient -> countryByCode(code = "LK");
    io:println(response.country?.name);
}
