# Service - Basic Auth file user store

A gRPC service/resource can be secured with Basic Auth and optionally by
enforcing authorization. Then, it validates the Basic Auth token sent as the
`Authorization` metadata against the provided configurations. This reads data
from a file, which has a TOML format. This stores the usernames, passwords
for authentication, and scopes for authorization.<br/>
Ballerina uses the concept of scopes for authorization. A resource declared
in a service can be bound to one/more scope(s).<br/>
In the authorization phase, the scopes of the service/resource are compared
against the scope included in the user store for at least one match between
the two sets.<br/>
`Config.toml` has defined three users - alice, ldclakmal, and eve. Each user has a
password and optionally assigned scopes as an array.<br/><br/>
For more information on the underlying module,
see the [Auth module](https://docs.central.ballerina.io/ballerina/auth/latest/).

::: code grpc_service.proto :::

::: out grpc_service.out :::

::: code grpc_service_basic_auth_file_user_store.bal :::

::: out grpc_service_basic_auth_file_user_store.server.out :::