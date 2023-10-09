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
    {id: 2, name: "Stephen King"}
];

final readonly & table<BookRow> key(id) bookTable = table [
    {id: 1, title: "Harry Potter and the Sorcerer's Stone", author: 1},
    {id: 2, title: "The Shining", author: 2},
    {id: 3, title: "Harry Potter and the Chamber of Secrets", author: 1},
    {id: 4, title: "It", author: 2},
    {id: 5, title: "Harry Potter and the Prisoner of Azkaban", author: 1},
    {id: 6, title: "The Stand", author: 2}
];

// Implement the `batch load` function for the data loader. 
// This function handles fetching data in batches. The primary keys of the data to be loaded
// will be provided as the values of the `ids` parameter to the batch load function. The expected output
// of this function is an array of results in which each element in the result array corresponds
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
    contextInit
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

    // Define a prefetch function.
    isolated function preBooks(graphql:Context ctx) {
        // Obtain the dataloader from the context using the unique name.
        // Providing an invalid name here will lead to a panic.
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

isolated function contextInit(http:RequestContext requestContext, http:Request request) returns graphql:Context {
    graphql:Context ctx = new;
    // Register the dataloader with the context using a unique name.
    // A defult implementation of the dataloader is used here.
    ctx.registerDataLoader("bookLoader", new dataloader:DefaultDataLoader(bookLoaderFunction));
    return ctx;
}
