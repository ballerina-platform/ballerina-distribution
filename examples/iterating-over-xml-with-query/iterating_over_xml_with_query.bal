import ballerina/io;

type Book record {|
    string id;
    string name;
|};

public function main() {
    xml categories = xml `<categories>
                       <category>
                           <id>1</id>
                           <name>cooking</name>
                       </category>
                       <category>
                           <id>2</id>
                           <name>children</name>
                       </category>
                       <category>
                           <id>3</id>
                           <name>fantasy</name>
                       </category>
                   </categories>`;

    // Iterates through the `categories` XML sequence, constructs the `Book` records,
    // and collects them into a table.
    table<Book> books = from var category in categories/<category>
                        select {
                            id: (category/<id>).toString(),
                            name: (category/<name>).toString()
                        };

    io:println(books);
}
