import ballerina/http;
import ballerina/mcp;

type Order record {|
    string id;
    string tenantId;
    string status;
    decimal total;
|};

final readonly & Order[] orders = [
    {id: "ORD-1001", tenantId: "acme", status: "shipped", total: 120.50},
    {id: "ORD-1002", tenantId: "acme", status: "processing", total: 89.99},
    {id: "ORD-2001", tenantId: "globex", status: "shipped", total: 540.00}
];

// Declare the service with the `mcp:StreamableHttpService` type to allow tools
// to bind information from the underlying HTTP request.
@mcp:StreamableHttpServiceConfig {
    info: {name: "Order MCP Server", version: "1.0.0"}
}
service mcp:StreamableHttpService /mcp on new mcp:StreamableHttpListener(9092) {

    // In addition to the tool parameters, a tool can accept an `http:Headers` parameter
    // (or an `http:Request` parameter) to access the HTTP request. These parameters are
    // not part of the tool's input schema, so the AI client never provides them.
    # Get the orders of the tenant making the request.
    #
    # + headers - The HTTP headers of the incoming request
    # + status - The order status to filter by (e.g., "shipped")
    # + return - The matching orders
    remote function getOrders(http:Headers headers, string? status = ()) returns Order[]|error {
        string tenantId = check headers.getHeader("x-tenant-id");
        return from Order o in orders
            where o.tenantId == tenantId && (status is () || o.status == status)
            select o;
    }

    // Alternatively, bind a specific header directly using the `@http:Header` annotation.
    # Get an order by ID for the tenant making the request.
    #
    # + orderId - The order ID
    # + tenantId - The tenant ID, bound from the `x-tenant-id` HTTP header
    # + return - The order details
    remote function getOrder(string orderId, @http:Header {name: "x-tenant-id"} string tenantId)
            returns Order|error {
        Order[] matching = from Order o in orders
            where o.id == orderId && o.tenantId == tenantId
            select o;
        if matching.length() == 0 {
            return error(string `Order ${orderId} not found for tenant ${tenantId}`);
        }
        return matching[0];
    }
}
