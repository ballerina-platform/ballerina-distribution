import ballerina/http;

http:Client orderManagementClient = new("http://localhost:9117/ordermgt");

json responsePayload = {};

public function findOrder(string orderId) returns (json) {
    var response = orderManagementClient->get("/order/" + orderId);

    if (response is http:Response) {
        return handleResponse(response);
    } else {
        return {"Error" : "Server error" };
    }
}

public function addOrder(json orderPayload) returns (json) {

    json IDJson = <json> orderPayload.Order.ID;
    string ID = IDJson.toJsonString();
    json foundOrder = findOrder(ID.toJsonString());

    if (foundOrder == {"Error" : "Order : " + ID + " cannot be found."} ) {
        var response = orderManagementClient->post("/order", orderPayload);

        if (response is http:Response) {
            return handleResponse(response);
        } else {
            return "Server error";
        }
    } else {
        return "Order with same ID already exists";
    }

}

function handleResponse(http:Response response) returns (json) {
    var jsonPayload = response.getJsonPayload();

    if (jsonPayload is json) {
        return <@untainted> jsonPayload;
    } else {
        return { "Error" : "Malformed Payload recieved"};
    }
}
