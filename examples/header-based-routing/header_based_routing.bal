import ballerina/http;
import ballerina/log;

http:ClientConfiguration weatherEPConfig = {
    followRedirects: {enabled: true, maxCount: 5},
    secureSocket: {
        cert: "../resource/path/to/public.crt"
    }
};

//Service is invoked using `basePath` value "/hbr".
service /hbr on new http:Listener(9090) {

    resource function get route(http:Caller caller,
                    @http:Header{name:"x-type"} string nameString) {
        http:Client weatherEP = checkpanic new (
                                    "http://samples.openweathermap.org",
                                     weatherEPConfig);
        http:Client locationEP = checkpanic new ("http://www.mocky.io");
        // Create a new outbound request to handle client call.
        http:Request newRequest = new;
        http:Response|error response;
        if (nameString == "location") {
            //[post()](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client#post) remote function represents the 'POST' operation
            // of the HTTP client.
            // Route payload to the relevant service.
            response = locationEP->post("/v2/5adddd66300000bd2a4b2912",
                                        newRequest);

        } else {
            //[get()](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client#get) remote function can be used to make an http GET call.
            response =
                weatherEP->get("/data/2.5/weather?lat=35&lon=139&appid=b1b1");

        }

        if (response is http:Response) {
            // [respond()](https://docs.central.ballerina.io/ballerina/http/latest/clients/Caller#respond) sends back the inbound clientResponse to the caller
            // if no error occurs.

            var result = caller->respond(<@untainted>response);

            if (result is error) {
                log:printError("Error sending response", 'error = result);
            }

        } else {
            http:Response errorResponse = new;
            errorResponse.statusCode = 500;
            errorResponse.setPayload(<@untainted>response.message());
            var result = caller->respond(errorResponse);

            if (result is error) {
                log:printError("Error sending response", 'error = result);
            }
        }
    }
}
