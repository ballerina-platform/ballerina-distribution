import ballerina/mcp;

type Salary record {|
    string employeeId;
    decimal amount;
    string currency;
|};

// The MCP Streamable HTTP transport is built on HTTP, so the listener accepts the
// same configuration as an `http:Listener`, including TLS via `secureSocket`.
listener mcp:StreamableHttpListener securedListener = new (9093,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

// Secure the MCP service with JWT authentication and enforce authorization with scopes.
// The JWT sent in the `Authorization` header is validated against the issuer, the audience,
// and the signature (using the public certificate), and the scopes in the `scp` claim are
// checked against the `scopes` field. The `httpConfig` field accepts the same configuration
// as the `@http:ServiceConfig` annotation, so basic authentication (file or LDAP user store)
// and OAuth2 introspection can be configured in the same way.
@mcp:StreamableHttpServiceConfig {
    info: {name: "Payroll MCP Server", version: "1.0.0"},
    httpConfig: {
        auth: [
            {
                jwtValidatorConfig: {
                    issuer: "wso2",
                    audience: "ballerina",
                    signatureConfig: {
                        certFile: "../resource/path/to/public.crt"
                    },
                    scopeKey: "scp"
                },
                scopes: ["admin"]
            }
        ]
    }
}
service mcp:StreamableHttpService /mcp on securedListener {

    # Get the salary details of an employee.
    #
    # + employeeId - The employee ID
    # + return - The salary details
    remote function getSalary(string employeeId) returns Salary {
        return {employeeId, amount: 5000.00, currency: "USD"};
    }
}
