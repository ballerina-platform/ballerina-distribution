import ballerina/http;
import ballerina/log;

// Header name to be set to the request in the filter.
final string filter_name_header = "X-requestHeader";
// Header value to be set to the request in the filter.
final string filter_name_header_value = "RequestFilter";

// The [Request](https://docs.central.ballerina.io/ballerina/http/latest/classes/Request) implementation.
// It intercepts the request and adds a new header to the request before it is dispatched to the HTTP resource.
public class RequestFilter {
    *http:RequestFilter;
    // [Intercepts the request](https://docs.central.ballerina.io/ballerina/http/latest/classes/Request#filterRequest).
    public isolated function filterRequest(http:Caller caller,
                        http:Request request, http:FilterContext context)
                        returns boolean {
        // Set a header to the request inside the filter.
        request.setHeader(filter_name_header, filter_name_header_value);
        // Return true on success.
        return true;
    }
}

// Creates a new RequestFilter.
RequestFilter requestFilter = new;

// The [response(https://docs.central.ballerina.io/ballerina/http/latest/classes/Response) implementation.
// It intercepts the response in the response path and adds a new header to the response.
public class ResponseFilter {
    *http:ResponseFilter;
    // [Intercepts the response](https://docs.central.ballerina.io/ballerina/http/latest/classes/Response#filterResponse).
    public isolated function filterResponse(http:Response response, 
                        http:FilterContext context) returns boolean {
        // Sets a header to the response inside the filter.
        response.setHeader("X-responseHeader", "ResponseFilter");
        // Return true on success.
        return true;
    }
}

// Creates a new [Response](https://docs.central.ballerina.io/ballerina/http/latest/classes/Response).
ResponseFilter responseFilter = new;

// Creates an HTTP listener and assigns the [filters as a config parameter](https://docs.central.ballerina.io/ballerina/http/latest/records/ListenerConfiguration).
listener http:Listener echoListener = new http:Listener(9090,
                    config = {filters: [requestFilter, responseFilter]});

service /hello on echoListener {

    resource function get sayHello(http:Caller caller, http:Request req) {
        // Create a new http response.
        http:Response res = new;
        // Set the `filter_name_header` from the request to the response.
        res.setHeader(filter_name_header, req.getHeader(filter_name_header));
        res.setPayload("Hello, World!");
        var result = caller->respond(<@untainted>res);
        if (result is error) {
            log:printError("Error sending response", err = result);
        }
    }
}
