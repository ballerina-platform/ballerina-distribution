import ballerina/http;
import ballerina/log;

type MapJson map<json>;
type Person record {|
    string name;
    int age;
|};

http:Client backendClient = check new("http://localhost:9092");

service /call on new http:Listener(9090) {

    resource function get all() returns http:Response|error {
        // The `string` typedesc is being passed to the `get` [client remote function](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client#get)
        // as the `targetType` expecting the payload to be bound to a string value.
        var result = backendClient->
                        get("/backend/String", targetType = string);

        // In this instance, The return type of the client remote action is `string` or `http:ClientError`.
        if (result is error) {
            log:printError("Error: " + result.message());
            return result;
        } else {
            // It implies that the [payload type](https://docs.central.ballerina.io/ballerina/http/latest/types#Payload)
            // is string.
            log:printInfo("String payload: " + result);
        }

        // Binding the payload to a JSON type. If an error returned, it will be responded back to the caller.
        json jsonPayload = check backendClient->
                        post("/backend/Json", "foo", targetType = json);

        log:printInfo("Json payload: " + jsonPayload.toJsonString());

        // Since only the `named types` or `built-in types` can be passed as function parameters,  `Map` or `Array`
        // types have to be defined beforehand. Here, the type `MapJson` is passed instead of `map<json>`.
        // Same can be done for `byte[]` or `Person[]` as well.
        map<json> value = check backendClient->
                        post("/backend/Json", "foo", targetType = MapJson);
        log:printInfo(check value.id);

        // A `record` and `record[]` are also possible types for data binding.
        Person person = check backendClient->
                            get("/backend/person", targetType = Person);
        log:printInfo("Person name: " + person.name);

        // When the complete response is expected, the default value of the `targetType` will be applied.
        http:Response res =  check backendClient->get("/backend/Response");
        return res;
    }

    resource function get '5xx() returns http:Response|json {
        var res = backendClient->
                        post("/backend/5XX", "want 500", targetType = json);
        // When the data binding is expected to happen and if the `post` remote function gets a 5XX response from the
        // backend, the response will be returned as an [http:RemoteServerError](https://docs.central.ballerina.io/ballerina/http/latest/errors#RemoteServerError)
        // including the error message and status code.
        if (res is error) {
            http:Response resp = new;
            if (res is http:RemoteServerError) {
                resp.statusCode = res.detail()?.statusCode ?: 500;
            } else {
                resp.statusCode = 500;
            }
            resp.setPayload(<@untainted>res.message());
            return resp;
        } else {
            return res;
        }
    }

    resource function get '4xx() returns http:Response|json {
        // When the data binding is expected to happen and if the client remote function gets a 4XX response from the
        // backend, the response will be returned as an [http:ClientRequestError](https://docs.central.ballerina.io/ballerina/http/latest/errors#ClientRequestError)
        // including the error message and status code.
        var res = backendClient->
                        post("/backend/err", "want 400", targetType = json);
        if (res is error) {
            http:Response resp = new;
            if (res is http:ClientRequestError) {
                resp.statusCode = res.detail()?.statusCode ?: 400;
            } else {
                resp.statusCode = 500;
            }
            resp.setPayload(<@untainted>res.message());
            return resp;
        } else {
            return res;
        }
    }
}

service /backend on new http:Listener(9092) {

    resource function get 'String() returns string {
        return "Hello ballerina!!!!";
    }

    resource function post 'Json() returns json {
        return {id: "Ballerina", values: {a: {x: "b"}}};
    }

    resource function get person() returns record {|*http:Ok; Person body;|} {
        return {body: {name: "Smith", age: 15}};
    }

    resource function get 'Response() returns http:Ok {
        return {
            body: {id: "data-binding-done"},
            headers: {"x-fact":"backend-payload"}
        };
    }

    resource function post '5XX() returns http:NotImplemented {
        return {body:"data-binding-failed-with-501"};
    }
}
