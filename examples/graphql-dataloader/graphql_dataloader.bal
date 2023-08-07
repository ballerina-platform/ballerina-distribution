import ballerina/graphql;
import ballerina/graphql.dataloader;
import ballerina/http;
import ballerina/log;

public type Book record {|
    int id;
    string title;
|};

type BookRow record {|
    readonly int id;
    string title;
    int author;
|};

type AuthorRow record {|
    readonly int id;
    string name;
|};

final readonly & table<AuthorRow> key(id) authorTable = table [
    {id: 1, name: "J.K. Rowling"},
    {id: 2, name: "Stephen King"},
    {id: 3, name: "Agatha Christie"},
    {id: 4, name: "Haruki Murakami"},
    {id: 5, name: "Jane Austen"}
];

final readonly & table<BookRow> key(id) bookTable = table [
    {id: 1, title: "Harry Potter and the Sorcerer's Stone", author: 1},
    {id: 2, title: "The Shining", author: 2},
    {id: 3, title: "Murder on the Orient Express", author: 3},
    {id: 4, title: "Norwegian Wood", author: 4},
    {id: 5, title: "Pride and Prejudice", author: 5},
    {id: 6, title: "Harry Potter and the Chamber of Secrets", author: 1},
    {id: 7, title: "It", author: 2},
    {id: 8, title: "And Then There Were None", author: 3},
    {id: 9, title: "Kafka on the Shore", author: 4}
];

// Implement the batch load function for the data loader. 
// This function handles fetching data in batches. The primary keys of the data to be loaded
// will be provided as the `ids` parameter to the batch load function. The expected output
// of this function is an array of results, where each element in the result array corresponds
// to a primary key from the `ids` array.
isolated function bookLoaderFunction(readonly & anydata[] ids) returns BookRow[][]|error {
    final readonly & int[] keys = check ids.ensureType();
    log:printInfo("executing bookLoaderFunction", keys = keys);
    // Implement the batching logic.
    return keys.'map(isolated function(readonly & int key) returns BookRow[] {
        return bookTable.'filter(book => book.author == key).toArray();
    });
}

@graphql:ServiceConfig {
    contextInit: isolated function(http:RequestContext requestContext, http:Request request) 
    returns graphql:Context {
        graphql:Context ctx = new;
        // Register the dataloader with the context using a unique name.
        // A defult implementation of the dataloader is used here.
        ctx.registerDataLoader("bookLoader", new dataloader:DefaultDataLoader(bookLoaderFunction));
        return ctx;
    }
}
service /graphql on new graphql:Listener(9090) {
    resource function get authors() returns Author[] {
        return from AuthorRow authorRow in authorTable
            select new (authorRow);
    }
}

public isolated distinct service class Author {
    private final readonly & AuthorRow author;

    isolated function init(readonly & AuthorRow author) {
        self.author = author;
    }

    isolated resource function get name() returns string {
        return self.author.name;
    }

    // Define a prefetch function that will be called before the curresponding 
    // field resolver function. In this case, the prefetch function will be called before 
    // the `books` field resolver function. By default the prefetch function name is 
    // prefix `pre` followed by the field name (.i.e. preBooks)
    isolated function preBooks(graphql:Context ctx) {
        // Obtain the dataloader from the context using the unique name.
        dataloader:DataLoader bookLoader = ctx.getDataLoader("bookLoader");
        // Add the primary key of the data to be fetched to the dataloader.
        bookLoader.add(self.author.id);
    }

    isolated resource function get books(graphql:Context ctx) returns Book[]|error {
        // Obtain the dataloader from the context using the unique name.
        dataloader:DataLoader bookLoader = ctx.getDataLoader("bookLoader");
        // Obtain the data from the dataloader using the primary key of the data.
        BookRow[] bookrows = check bookLoader.get(self.author.id);
        return from BookRow bookRow in bookrows
            select {id: bookRow.id, title: bookRow.title};
    }
}
