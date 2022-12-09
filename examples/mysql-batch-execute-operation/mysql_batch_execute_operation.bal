import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// The `Album` record to load records from `albums` table.
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

    resource function post albums(@http:Payload Album[] albums) returns http:Created|error {
        // Create a batch parameterized query.
        sql:ParameterizedQuery[] insertQueries = from Album album in albums
            select `INSERT INTO albums (id, title, artist, price)
                    VALUES (${album.id}, ${album.title}, ${album.artist}, ${album.price})`;

        // Insert records in a batch.
        _ = check self.db->batchExecute(insertQueries);
        return http:CREATED;
    }
}
