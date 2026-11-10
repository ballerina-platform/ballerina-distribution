import ballerina/mcp.v2 as mcpv2;

enum Seating {
    INDOOR = "indoor",
    PATIO = "patio"
}

// The fields of this record become the fields of the form shown to the user.
// The documentation of each field becomes its description.
type TableBooking record {|
    # Who the table is for
    string name;
    # How many people are coming
    int guests;
    # Where to sit
    Seating seating;
|};

listener mcpv2:StreamableHttpListener mcpListener = check new (9090);

@mcpv2:StreamableHttpServiceConfig {
    info: {
        name: "restaurant",
        version: "1.0.0"
    }
}
service mcpv2:StreamableHttpService /mcp on mcpListener {

    # Book a table at the restaurant.
    #
    # + date - The date of the booking (e.g., "2026-12-24")
    # + context - The input the user provided for this call
    # + return - The booking confirmation, or a request for the booking details
    remote isolated function bookTable(string date, mcpv2:Context context)
            returns string|mcpv2:InputRequiredResult {
        // Read the user's answer to the `booking` input request, if any.
        TableBooking? booking = context.acceptedContent("booking");
        if booking is () {
            // Ask the client to collect the booking details from the user.
            // The client retries the call with the answer, and the tool runs again.
            return {
                inputRequests: {
                    "booking": mcpv2:elicitForm(string `Book a table on ${date}`, TableBooking)
                }
            };
        }
        return string `Booked a ${booking.seating} table for ${booking.guests} on ${date} under ${booking.name}`;
    }
}
