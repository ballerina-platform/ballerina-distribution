import ballerina/grpc;

listener grpc:Listener securedEP = new (9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

// Basic authentication with the LDAP user store can be enabled by setting
// the `grpc:LdapUserStoreConfig` configuration.
// Authorization is based on scopes, which can be specified in the `scopes` field.
@grpc:ServiceConfig {
    auth: [
        {
            ldapUserStoreConfig: {
                domainName: "avix.lk",
                connectionUrl: "ldap://localhost:389",
                connectionName: "cn=admin,dc=avix,dc=lk",
                connectionPassword: "avix123",
                userSearchBase: "ou=Users,dc=avix,dc=lk",
                userEntryObjectClass: "inetOrgPerson",
                userNameAttribute: "uid",
                userNameSearchFilter: "(&(objectClass=inetOrgPerson)(uid=?))",
                userNameListFilter: "(objectClass=inetOrgPerson)",
                groupSearchBase: ["ou=Groups,dc=avix,dc=lk"],
                groupEntryObjectClass: "groupOfNames",
                groupNameAttribute: "cn",
                groupNameSearchFilter: "(&(objectClass=groupOfNames)(cn=?))",
                groupNameListFilter: "(objectClass=groupOfNames)",
                membershipAttribute: "member",
                userRolesCacheEnabled: true,
                connectionPoolingEnabled: false,
                connectionTimeout: 5,
                readTimeout: 60
            },
            scopes: ["admin"]
        }
    ]
}
@grpc:Descriptor {
    value: GRPC_SIMPLE_DESC
}
service "HelloWorld" on securedEP {

    remote function hello(string request) returns string {
        return "Hello " + request;
    }
}
