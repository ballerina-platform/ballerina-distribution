import ballerina/http;
import ballerina/log;

listener http:Listener httpListener = new(9117);

map<json> ordersMap = {};

@http:ServiceConfig { 
    basePath: "/ordermgt" 
}
service OrderManagementService on httpListener {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/order/{orderId}"
    }
    resource function find(http:Caller caller, http:Request req, string orderId) {
        json? payload = ordersMap[orderId];
        http:Response response = new;
        if (payload == null) {
            payload = { "Error" : "Order : " + orderId + " cannot be found." };
        }

        response.setJsonPayload(<@untainted> payload);

        var result = caller->respond(response);
        if (result is error) {
            log:printError("Error sending response", err = result);
        }
    }

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/order"
    }
    resource function add(http:Caller caller, http:Request req) {
        http:Response response = new;
        var orderReq = req.getJsonPayload();
        if (orderReq is json) {
            string orderId = orderReq.Order.ID.toString();
            ordersMap[orderId] = <@untainted> orderReq;

            json payload = { status: "Order Created.", orderId: orderId };
            response.setJsonPayload(payload);

            response.statusCode = 201;

            response.setHeader("Location", 
                "http://localhost:9117/ordermgt/order/" + orderId);

            var result = caller->respond(response);
            if (result is error) {
                log:printError("Error sending response", err = result);
            }
        } else {
            response.statusCode = 400;
            response.setPayload("Invalid payload received");
            var result = caller->respond(response);
            if (result is error) {
                log:printError("Error sending response", err = result);
            }
        }
    }
}
