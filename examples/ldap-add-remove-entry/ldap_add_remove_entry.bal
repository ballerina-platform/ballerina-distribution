import ballerina/io;
import ballerina/ldap;

public function main() returns error? {
    // Initializes a new LDAP client with credentials.
    ldap:Client ldapClient = check new ({
        hostName: "localhost",
        port: 389,
        domainName: "cn=admin,dc=example,dc=com",
        password: "adminpassword"
    });

    // Adds an entry to the directory server.
    ldap:LdapResponse addResponse = check ldapClient->add(
        "cn=user,dc=example,dc=com",
        {
            "objectClass": ["top", "person"],
            "sn": "user",
            "cn": "user"
        }
    );
    io:println("Add Response: ", addResponse.resultCode);

    // Deletes an entry from the directory server.
    ldap:LdapResponse deleteResponse = check ldapClient->delete("cn=user,dc=example,dc=com");
    io:println("Delete Response: ", deleteResponse.resultCode);
}
