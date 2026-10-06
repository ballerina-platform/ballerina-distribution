import ballerina/ai;
import ballerina/io;

# Represents a resolved support ticket stored in a ticketing system.
type Ticket record {|
    # The ticket identifier
    string id;
    # A short summary of the issue
    string subject;
    # How the issue was resolved
    string resolution;
|};

// A custom data loader that implements the `ai:DataLoader` type. Any source can be exposed
// as a data loader: a database, an API, a ticketing system, etc. Here, the loader turns
// ticket records into text documents, keeping the ticket details as metadata.
isolated class TicketDataLoader {
    *ai:DataLoader;

    private final readonly & Ticket[] tickets;

    isolated function init(Ticket[] tickets) {
        self.tickets = tickets.cloneReadOnly();
    }

    // The `load` method is the only method of the `ai:DataLoader` type. It returns a single
    // document or an array of documents.
    public isolated function load() returns ai:Document[]|ai:Document|ai:Error {
        ai:Document[] documents = [];
        foreach Ticket ticket in self.tickets {
            ai:TextDocument document = {
                content: string `${ticket.subject}: ${ticket.resolution}`,
                metadata: {"origin": "ticketing-system", "ticketId": ticket.id}
            };
            documents.push(document);
        }
        return documents;
    }
}

public function main() returns error? {
    // In a real application, the records would be read from the ticketing system's API
    // or database.
    ai:DataLoader ticketLoader = new TicketDataLoader([
        {id: "T-1042", subject: "VPN disconnects", resolution: "Update the VPN client to version 5.2 or later."},
        {
            id: "T-1043",
            subject: "Expense portal login",
            resolution: "Reset the SSO password and clear the browser cache."
        }
    ]);

    // The custom loader is used like the built-in loaders. Its documents can be chunked
    // and ingested into a knowledge base in the same way.
    ai:Document|ai:Document[] loaded = check ticketLoader.load();
    ai:Document[] documents = loaded is ai:Document[] ? loaded : [loaded];

    io:println("Documents loaded: ", documents.length());
    foreach ai:Document document in documents {
        io:println("- ", document.metadata.toJson(), ": ", document.content);
    }
}
