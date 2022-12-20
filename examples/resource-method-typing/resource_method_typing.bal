import ballerina/http;

type Args record {|
   decimal x;
   decimal y;
|};

type Response record {|
    decimal result;
|};

listener http:Listener ln = new (9090);

service /calc on ln {
   // Resource method arguments can use user-defined types.
   // Annotations can be used to refine the mapping between the Ballerina-declared
   // type and wire format.
   resource function post add(@http:Payload Args args) returns Response {
      return {result: args.x + args.y};
   }
}
