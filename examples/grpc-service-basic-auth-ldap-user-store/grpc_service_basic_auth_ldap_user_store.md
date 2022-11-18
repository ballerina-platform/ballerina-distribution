# gRPC service - Basic auth LDAP user store

A gRPC service/resource can be secured with Basic Auth and by enforcing authorization optionally. Then, it validates the Basic Auth token sent in the `Authorization` metadata against the provided configurations. This reads data from the configured LDAP. This stores usernames, passwords for authentication, and scopes for authorization.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s).

In the authorization phase, the scopes of the service/resource are compared against the scope included in the user store for at least one match between the two sets.

>**Info:** For more information on the underlying module, see the [`auth` module](https://lib.ballerina.io/ballerina/auth/latest/).

>**Info:** Setting up the service is the same as setting up the simple RPC service with additional configurations. You can refer to the [simple RPC service](/learn/by-example/grpc-service-simple/) to implement the service used below.

>**Tip:** You may need to change the certificate file path and private key file path in the code below. 

   ::: code grpc_service_basic_auth_ldap_user_store.bal :::

Execute the command below to run the service.

   ::: out grpc_service_basic_auth_ldap_user_store.server.out :::

>**Info:** You can invoke the above service via the [gRPC Basic Auth client](/learn/by-example/grpc-client-basic-auth).
