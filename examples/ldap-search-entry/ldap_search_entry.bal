import ballerina/ldap;
import ballerina/io;

public function main() returns error? {
    ldap:Client ldap = check new({
        hostName: "localhost",
        port: 389,
        domainName: "cn=admin,dc=example,dc=com",
        password: "adminpassword"
    });

    ldap:SearchResult searchResult = check ldap->search(
        "cn=user,dc=example,dc=com", 
        "(sn=user)",
        ldap:SUB
    );

    io:println("Search Response: ", searchResult.resultCode);
}
