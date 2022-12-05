import ballerina/http;
import ballerina/sql;
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

    resource function get albums() returns Album[]|error {
        // Execute simple query to retrieve all records from the `albums` table.
        stream<Album, sql:Error?> albumStream = self.db->query(`SELECT * FROM albums`);

        // Process the stream and convert results to Album[] or return error.
        return check from Album album in albumStream
            select album;
    }
}
