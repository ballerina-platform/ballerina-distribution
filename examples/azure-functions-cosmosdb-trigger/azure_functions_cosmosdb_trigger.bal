import ballerina/io;
import ballerinax/azure.functions;

public type DBEntry record {
    string id;
    string name;
};

@functions:CosmosDBTrigger {connectionStringSetting: "CosmosDBConnection", databaseName: "db1", collectionName: "c1"}
listener functions:CosmosDBListener cosmosEp = new ();

service "cosmos" on cosmosEp {
    remote function onUpdate(DBEntry[] entries) returns @functions:QueueOutput {queueName: "people"} string {
        string name = entries[0].name;
        io:println(entries.toJsonString());
        return "Hello, " + name;
    }
}
