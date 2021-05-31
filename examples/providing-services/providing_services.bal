import ballerina/http;

// Listener declarations are allowed at the module level. 
// They are similar to variable declarations, but register the newly created Listener object with the module.
// If `new` returns an error, then module initialization fails.
listener http:Listener h = new (8080);
