import ballerina/http;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Defines a record to load the query result.
type Album record {|
    string id;
    string title;
    string artist;
    float price;
|};

service / on new http:Listener(8080) {
    private final mysql:Client db;

    function init() returns error? {
        // Initiate the mysql client at the start of the service. This will be used
        // throughout the lifetime of the service.
        self.db = check new (host = "localhost", port = 3306, user = "root",
                            password = "Test@123", database = "MUSIC_STORE");
    }

    resource function post album(@http:Payload Album album) returns Album|error {
        _ = check self.db->execute(`
            INSERT INTO Albums (id, title, artist, price)
            VALUES (${album.id}, ${album.title}, ${album.artist}, ${album.price});`);
        return album;
    }
}
