import ballerina/http;

// Header name to be set to the response in the response interceptor.
final string interceptor_header1 = "X-responseHeader1";
final string interceptor_header2 = "X-responseHeader2";

// Header value to be set to the response in the response interceptor.
final string interceptor_header_value1 = "ResponseInterceptor1";
final string interceptor_header_value2 = "ResponseInterceptor2";

service class ResponseInterceptor1 {
    *http:ResponseInterceptor;

    remote function interceptResponse(http:RequestContext ctx, 
            http:Response res) returns http:NextService|error? {
        // Sets a header to the response inside the interceptor service.
        res.setHeader(interceptor_header1, interceptor_header_value1);
        return ctx.next();
    }
}

ResponseInterceptor1 responseInterceptor1 = new;

service class ResponseInterceptor2 {
    *http:ResponseInterceptor;

    remote function interceptResponse(http:RequestContext ctx, 
            http:Response res) returns http:NextService|error? {
        res.setHeader(interceptor_header2, interceptor_header_value2);
        // Sets a new text payload to the response.
        res.setTextPayload("Greetings from Interceptor!");
        return ctx.next();
    }
}

ResponseInterceptor2 responseInterceptor2 = new;

listener http:Listener interceptorListener = new http:Listener(9090);

// Engage interceptors at service level.
@http:ServiceConfig {
    // These interceptors will be executed only for this particular service
    interceptors: [responseInterceptor2, responseInterceptor1]
}
service /user on interceptorListener {

    resource function get greeting(http:Request req) 
            returns http:Response|error? {
        // Create a new response.
        http:Response response = new;
        response.setTextPayload("Greetings!");
        return response;
    }
}
