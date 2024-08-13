import ballerina/io;
import ballerina/ldap;

public function main() returns error? {
    // Initialized a new LDAP client.
    ldap:Client ldapClient = check new ({
        hostName: "localhost",
        port: 389,
        domainName: "cn=admin,dc=example,dc=com",
        password: "adminpassword"
    });

    // Searches for an entry in the directory server.
    ldap:SearchResult searchResult = check ldapClient->search(
        "cn=user,dc=example,dc=com",
        "(sn=user)",
        ldap:SUB
    );
    io:println("Search Response: ", searchResult.resultCode);
}
