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

    ldap:LdapResponse addResponse = check ldapClient->add(
        "cn=user,dc=example,dc=com",
        {
        "objectClass": ["top", "person"],
        "sn": "user",
        "cn": "user"
    }
    );
    io:println("Add Response: ", addResponse.resultCode);

    ldap:LdapResponse deleteResponse = check ldapClient->delete("cn=user,dc=example,dc=com");
    io:println("Delete Response: ", deleteResponse.resultCode);
}
