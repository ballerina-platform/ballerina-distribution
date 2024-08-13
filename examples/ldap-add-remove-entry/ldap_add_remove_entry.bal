import ballerina/ldap;
import ballerina/io;

public function main() returns error? {
    ldap:Client ldap = check new({
        hostName: "localhost",
        port: 389,
        domainName: "cn=admin,dc=example,dc=com",
        password: "adminpassword"
    });

    ldap:LdapResponse addResponse = check ldap->add(
        "cn=user,dc=example,dc=com", 
        {
            "objectClass": ["top", "person"],
            "sn": "user",
            "cn": "user"
        }
    );
    io:println("Add Response: ", addResponse.resultCode);

    ldap:LdapResponse deleteResponse = check ldap->delete("cn=user,dc=example,dc=com");
    io:println("Delete Response: ", deleteResponse.resultCode);
}
