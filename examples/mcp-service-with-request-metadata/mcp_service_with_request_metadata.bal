import ballerina/mcp;

type Ticket record {|
    string id;
    string tenantId;
    string subject;
    string priority;
|};

type SupportHours record {|
    string region;
    string hours;
|};

isolated Ticket[] tickets = [
    {id: "TCK-1", tenantId: "acme", subject: "Payment gateway timeout", priority: "high"},
    {id: "TCK-2", tenantId: "globex", subject: "Login fails on mobile", priority: "medium"},
    {id: "TCK-3", tenantId: "acme", subject: "Report export is empty", priority: "low"}
];

listener mcp:StreamableHttpListener mcpListener = new (9090);

service mcp:StreamableHttpService /mcp on mcpListener {

    # Gets the open support tickets of the calling tenant.
    #
    # + meta - The request metadata attached by the client
    # + return - The open tickets of the tenant, or an error if the tenant is not specified
    remote function getOpenTickets(mcp:Meta? meta) returns Ticket[]|error {
        // The runtime injects the `_meta` field of the request into the `mcp:Meta?` parameter
        // and leaves the parameter out of the tool input schema, so the tenant is never a tool
        // argument that a client, or an LLM, chooses. The parameter is nil when the request
        // carries no metadata.
        string tenantId = check getTenantId(meta);
        lock {
            Ticket[] tenantTickets = from Ticket ticket in tickets
                where ticket.tenantId == tenantId
                select ticket;
            return tenantTickets.clone();
        }
    }

    # Creates a support ticket for the calling tenant.
    #
    # + meta - The request metadata attached by the client
    # + subject - The subject of the ticket
    # + priority - The priority of the ticket (`low`, `medium`, or `high`)
    # + return - The created ticket, or an error if the tenant is not specified
    remote function createTicket(mcp:Meta? meta, string subject, string priority = "medium")
            returns Ticket|error {
        // The `mcp:Meta?` parameter is declared along with the other parameters of the tool.
        // Only the `subject` and `priority` parameters are the tool arguments.
        string tenantId = check getTenantId(meta);
        lock {
            Ticket ticket = {id: string `TCK-${tickets.length() + 1}`, tenantId, subject, priority};
            tickets.push(ticket);
            return ticket.clone();
        }
    }

    # Gets the support hours of a region. The support hours are the same for every tenant,
    # so this tool does not read the request metadata.
    #
    # + region - The region (e.g., `EU`, `US`)
    # + return - The support hours of the region
    remote function getSupportHours(string region) returns SupportHours => {
        region,
        hours: region == "EU" ? "08:00-18:00 CET" : "08:00-18:00 EST"
    };
}

// `mcp:Meta` is an open record, so the fields that the client sent are read by member access.
isolated function getTenantId(mcp:Meta? meta) returns string|error {
    anydata tenantId = meta is mcp:Meta ? meta["tenantId"] : ();
    if tenantId !is string {
        return error("The 'tenantId' metadata is missing from the request");
    }
    return tenantId;
}
