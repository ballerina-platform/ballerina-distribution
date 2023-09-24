import ballerina/graphql;
import ballerina/graphql.dataloader;
import ballerina/http;

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

isolated function bookLoaderFunction(readonly & anydata[] ids) returns BookRow[][]|error {
    final readonly & int[] keys = check ids.ensureType();
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

    // Define a prefetch function with a custom name.
    isolated function prefetchBooks(graphql:Context ctx) {
        dataloader:DataLoader bookLoader = ctx.getDataLoader("bookLoader");
        bookLoader.add(self.author.id);
    }

    // Annotate the resource function to use a prefetch function having a custom name.
    // This configuration instructs the GraphQL engine to call the `prefetchBooks` function
    // before calling the `books` resource function.
    @graphql:ResourceConfig {
        prefetchMethodName: "prefetchBooks"
    }
    isolated resource function get books(graphql:Context ctx) returns Book[]|error {
        dataloader:DataLoader bookLoader = ctx.getDataLoader("bookLoader");
        BookRow[] bookrows = check bookLoader.get(self.author.id);
        return from BookRow bookRow in bookrows
            select {id: bookRow.id, title: bookRow.title};
    }
}

isolated function contextInit(http:RequestContext requestContext, http:Request request)  returns graphql:Context {
    graphql:Context ctx = new;
    ctx.registerDataLoader("bookLoader", new dataloader:DefaultDataLoader(bookLoaderFunction));
    return ctx;
}