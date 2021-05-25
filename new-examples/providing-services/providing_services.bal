import ballerina/http;

// Listener declarations are allowed at the module level. 
// They are similar to variable declarations, but registers the newly crearted Listener object with the module.
// If `new` returns and error, then module initialization fails.
listener http:Listener h = new(8080);