import ballerina/http;

http:Client orderManagementClient = checkpanic new ("http://localhost:9117/ordermgt");

json responsePayload = {};

public function findOrder(string orderId) returns (json) {
    http:Response|error response = orderManagementClient->get("/order/" + orderId);

    if (response is http:Response) {
        return handleResponse(response);
    } else {
        return {"Error": "Server error"};
    }
}

public function addOrder(json orderPayload) returns (json) {

    json|error IDJson = orderPayload.Order.ID;

    if (IDJson is json) {
        string ID = IDJson.toJsonString();
        json foundOrder = findOrder(ID.toJsonString());

        if (foundOrder == {"Error": "Order : " + ID + " cannot be found."}) {
            http:Response|error response = orderManagementClient->post("/order", orderPayload);
            if (response is http:Response) {
                return handleResponse(response);
            } else {
                return "Server error";
            }
        } else {
            return "Order with same ID already exists";
        }
    } else {
        return "Server error";
    }
}

function handleResponse(http:Response response) returns (json) {
    var jsonPayload = response.getJsonPayload();

    if (jsonPayload is json) {
        return <@untainted>jsonPayload;
    } else {
        return {"Error": "Malformed Payload recieved"};
    }
}
