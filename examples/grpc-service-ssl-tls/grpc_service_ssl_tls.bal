import ballerina/grpc;

listener grpc:Listener securedEP = new (9090,
    secureSocket = {
        key: {
            certFile: "./resources/public.crt",
            keyFile: "./resources/private.key"
        }
    }
);

@grpc:Descriptor {
    value: GRPC_SIMPLE_DESC
}
service "HelloWorld" on securedEP {

    remote function hello(string request) returns string {
        return "Hello " + request;
    }
}
