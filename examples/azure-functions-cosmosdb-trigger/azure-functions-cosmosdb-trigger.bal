import ballerina/log;
import ballerinax/azure_functions as af;

public type DBEntry record {
    string id;
    string name;
};

@af:CosmosDBTrigger {connectionStringSetting: "CosmosDBConnection", databaseName: "db1", collectionName: "c1"}
listener af:CosmosDBListener cosmosEp = new ();

service "cosmos" on cosmosEp {
    remote function onUpdate(DBEntry[] entries) returns @af:QueueOutput {queueName: "people"} string {
        string name = entries[0].name;
        log:printInfo(entries.toJsonString());
        return "Hello, " + name;
    }
}