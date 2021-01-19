service /v1 on ep0, ep1 {

# Show a list of pets in the system
# + caller - Caller client object represents the endpoint
# + req    - Req represents the message which came along over the network
# + 'limit - How many items to return at one time (max 100)

# + return - Error value if an error occurred, and return nil otherwise
    resource function get pets(http:Caller caller, http:Request req ,  int ?  'limit) returns error? {

    }

}
