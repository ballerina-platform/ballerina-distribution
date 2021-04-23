import ballerina/http;

listener http:Listener securedEP = new(9090, config = {
    secureSocket: {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
});

// The service can be secured with Basic auth and can be authorized  optionally.
// Basic auth using the LDAP user store can be enabled by setting the
// `http:LdapUserStoreConfig` configurations.
// Authorization is based on scopes. A scope maps to one or more groups.
// Authorization can be enabled by setting the `string|string[]` type
// configurations.
@http:ServiceConfig {
    auth: [
        {
            ldapUserStoreConfig: {
                domainName: "ballerina.io",
                connectionUrl: "ldap://localhost:389",
                connectionName: "uid=admin,ou=system",
                connectionPassword: "secret",
                userSearchBase: "ou=Users,dc=ballerina,dc=io",
                userEntryObjectClass: "identityPerson",
                userNameAttribute: "uid",
                userNameSearchFilter: "(&(objectClass=person)(uid=?))",
                userNameListFilter: "(objectClass=person)",
                groupSearchBase: ["ou=Groups,dc=ballerina,dc=io"],
                groupEntryObjectClass: "groupOfNames",
                groupNameAttribute: "cn",
                groupNameSearchFilter: "(&(objectClass=groupOfNames)(cn=?))",
                groupNameListFilter: "(objectClass=groupOfNames)",
                membershipAttribute: "member",
                userRolesCacheEnabled: true,
                connectionPoolingEnabled: false,
                connectionTimeout: 5000,
                readTimeout: 60000
            },
            scopes: ["hello"]
        }
    ]
}
service /foo on securedEP {

    // It is optional to override the authentication and authorization
    // configurations at the resource levels. Otherwise, the service auth
    // configurations will be applied automatically to the resources as well.
    resource function get bar() returns string {
        return "Hello, World!";
    }
}
