import ballerina/http;

type Args record {|
    decimal x;
    decimal y;
|};

listener http:Listener h = new (9090);

service /calc on h {
    // Resource method arguments can use user-defined types.
    // Annotations can be used to refine the mapping between 
    // Ballerina-declared type and wire format.
    resource function post add(@http:Payload Args args) 
            returns decimal {
        return args.x + args.y;
    }

}
