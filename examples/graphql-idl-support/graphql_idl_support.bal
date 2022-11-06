import ballerina/io;
client "./graphql.config.yaml" as foo;

public function main() {
    do {
	    foo:client graphqlClient = check new (serviceUrl = "https://countries.trevorblades.com/");

        // Execute CountryByCode query
        foo:CountryByCodeResponse response = check graphqlClient->countryByCode(code = "LK");
        io:println(response.country?.name);
    } on fail var e {
    	io:print(e.detail());
    }
}
