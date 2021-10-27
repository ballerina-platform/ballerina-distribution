import ballerina/http;
import ballerina/log;

listener http:Listener httpListener = new(9117);

map<json> ordersMap = {};

service /ordermgt on httpListener {

    resource function get 'order/[string orderId](http:Caller caller, http:Request req) {
        json? payload = ordersMap[orderId];
        http:Response response = new;
        if (payload == null) {
            payload = { "Error" : "Order : " + orderId + " cannot be found." };
        }

        response.setJsonPayload(<@untainted> payload);

        var result = caller->respond(response);
        if (result is error) {
            log:printError("Error sending response");
        }
    }

    resource function post 'order(http:Caller caller, http:Request req) {
        http:Response response = new;
        var orderReq = req.getJsonPayload();
        if (orderReq is json) {
            json|error orderIdJson = orderReq.Order.ID;
            string orderId = "";

            if (orderIdJson is json) {
                orderId = orderIdJson.toString();
            } else {
                log:printError("Error sending response");
            }

            ordersMap[orderId] = <@untainted> orderReq;

            json payload = { status: "Order Created.", orderId: orderId };
            response.setJsonPayload(payload);

            response.statusCode = 201;

            response.setHeader("Location",
                "http://localhost:9117/ordermgt/order/" + orderId);

            var result = caller->respond(response);
            if (result is error) {
                log:printError("Error sending response");
            }
        } else {
            response.statusCode = 400;
            response.setPayload("Invalid payload received");
            var result = caller->respond(response);
            if (result is error) {
                log:printError("Error sending response");
            }
        }
    }
}
